import 'package:traid_admin/models/admin.dart';

sealed class AdminState {}

class InitAdminState extends AdminState {}

class LoadingAdminState extends AdminState {}

class ErrorAdminState extends AdminState {
  final String message;

  ErrorAdminState(this.message);
}

class ResponseAdminState extends AdminState {
  final List<Admin> admins;

  ResponseAdminState(this.admins);
}
