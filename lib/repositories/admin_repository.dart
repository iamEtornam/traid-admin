import 'package:traid_admin/models/admin.dart';
import 'package:traid_admin/util/network_utils/custom_http_client.dart';
import 'package:yet_another_json_isolate/yet_another_json_isolate.dart';

class AdminRepository {
  final _isolate = YAJsonIsolate()..initialize();

  Future<List<Admin>> getAllAdmins() async {
    const url = 'https://api.traid-dev.com/api/admin/user/all';
    final res = await CustomHttpClient.getRequest(url);
    if (res.statusCode == 200) {
      final json = await _isolate.decode(res.body) as List;
      return json.map((e) => Admin.fromJson(e)).toList();
    } else {
      throw 'Something went wrong.\n${res.statusCode}';
    }
  }
}
