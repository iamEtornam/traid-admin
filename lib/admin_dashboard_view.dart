// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traid_admin/components/custom_colors.dart';
import 'package:traid_admin/features/admin/view/admin_view.dart';
import 'package:traid_admin/features/network/view/network_view.dart';
import 'package:traid_admin/features/setting/view/setting_view.dart';
import 'package:traid_admin/resources/resources.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          AdminView(),
          NetworkView(),
          SettingView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) => setState(() => _currentIndex = value),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(Svgs.user),
                activeIcon: SvgPicture.asset(
                  Svgs.user,
                  color: TraidColor.irisAccent,
                ),
                backgroundColor: TraidColor.irisAccent,
                label: 'Traiders'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  Svgs.network,
                  color: TraidColor.irisAccent,
                ),
                icon: SvgPicture.asset(Svgs.network),
                backgroundColor: TraidColor.irisAccent,
                label: 'Network'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  Svgs.setting,
                  color: TraidColor.irisAccent,
                ),
                icon: SvgPicture.asset(Svgs.setting),
                backgroundColor: TraidColor.irisAccent,
                label: 'Settings'),
          ]),
    );
  }
}
