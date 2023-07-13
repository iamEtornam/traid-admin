// ignore_for_file: implementation_imports

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/src/storage/file_system/file_system.dart'
    as c;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CustomCacheHandler {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
}

class IOFileSystem implements c.FileSystem {
  final Future<Directory> _fileDir;

  IOFileSystem(String key) : _fileDir = createDirectory(key);

  static Future<Directory> createDirectory(String key) async {
    var baseDir = await getTemporaryDirectory();
    var path = p.join(baseDir.path, key);

    var fs = const LocalFileSystem();
    var directory = fs.directory((path));
    await directory.create(recursive: true);
    return directory;
  }

  @override
  Future<File> createFile(String name) async {
    return (await _fileDir).childFile(name);
  }
}
