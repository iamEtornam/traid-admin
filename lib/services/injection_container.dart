import 'package:get_it/get_it.dart';
import 'package:traid_admin/repositories/admin_repository.dart';

final getIt = GetIt.instance;

void initFeatures() {
  getIt.registerSingleton<AdminRepository>(AdminRepository());
}
