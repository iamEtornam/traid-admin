import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traid_admin/features/admin/cubit/admin_state.dart';
import 'package:traid_admin/repositories/admin_repository.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository adminRepository;
  AdminCubit(this.adminRepository) : super(InitAdminState());

  Future<void> fetch() async {
    emit(LoadingAdminState());
    try {
      final res = await adminRepository.getAllAdmins();
      emit(ResponseAdminState(res));
    } catch (e) {
      emit(ErrorAdminState(e.toString()));
    }
  }
}
