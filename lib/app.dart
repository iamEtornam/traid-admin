import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traid_admin/admin_dashboard_view.dart';
import 'package:traid_admin/components/custom_colors.dart';
import 'package:traid_admin/features/admin/cubit/admin_cubit.dart';
import 'package:traid_admin/repositories/admin_repository.dart';
import 'package:traid_admin/services/injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(getIt.get<AdminRepository>()),
      child: MaterialApp(
        title: 'Traid Admin',
        theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: TraidColor.irisAccent),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromRGBO(242, 242, 245, 1)),
        home: const AdminDashboardView(),
      ),
    );
  }
}
