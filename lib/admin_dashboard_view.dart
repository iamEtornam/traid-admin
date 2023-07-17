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
  List<Map<String, dynamic>> pages = [
    {
      'page': const AdminView(),
      'label': 'My Traiders',
    },
    {
      'page': const NetworkView(),
      'label': 'My Networks',
    },
    {
      'page': const SettingView(),
      'label': 'My Settings',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pages[_currentIndex]['label'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'Inter'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: pages.map<Widget>((e) => e['page']).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) => setState(() => _currentIndex = value),
          selectedFontSize: 10,
          selectedIconTheme: IconThemeData(color: TraidColor.irisAccent),
          selectedItemColor: TraidColor.irisAccent,
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedFontSize: 10,
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
          items: [
            _navigationTabs(icon: Svgs.user, label: 'Traiders'),
            _navigationTabs(icon: Svgs.network, label: 'Network'),
            _navigationTabs(icon: Svgs.setting, label: 'Settings'),
          ]),
    );
  }
}

BottomNavigationBarItem _navigationTabs({required String label, required String icon}) {
  return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
      ),
      activeIcon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        color: TraidColor.irisAccent,
      ),
      label: label);
}
