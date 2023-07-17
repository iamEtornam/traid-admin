import 'package:flutter/material.dart';
import 'package:traid_admin/components/custom_colors.dart';
import 'package:traid_admin/features/admin/cubit/admin_state.dart';
import 'package:traid_admin/features/admin/view/components/add_new_traider.dart';
import 'package:traid_admin/features/admin/view/components/traider_listtile_widget.dart';

class TraiderWidget extends StatefulWidget {
  const TraiderWidget({super.key, required this.responseAdminState, required this.images});

  final ResponseAdminState responseAdminState;
  final List<String> images;

  @override
  State<TraiderWidget> createState() => _TraiderWidgetState();
}

class _TraiderWidgetState extends State<TraiderWidget> {
  final scrollController = ScrollController();

  List options = [];
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    final admins = widget.responseAdminState.admins;
    final totalTraider = admins.length;
    const totalGroups = 0;
    final totalRules = admins.map((e) => e.userRoles).expand((element) => element).toSet().length;
    options = options = [
      {'label': 'Traiders', 'count': totalTraider},
      {'label': 'Group', 'count': totalGroups},
      {'label': 'Rules', 'count': totalRules},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(options.length, (index) => traiderFilterWidget(index, context)),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            controller: scrollController,
            children: [
              AddNewTraiderWidget(
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: ListView.separated(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final admin = admins[index];
                      final userRoles = admin.userRoles.join(", ");
                      final roles = userRoles.replaceAll('_', ' ');
                      final role = roles.isEmpty ? 'N/A' : roles;
                      return TraiderListTileWidget(images: widget.images, admin: admin, role: role);
                    },
                    separatorBuilder: (__, _) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: admins.length),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget traiderFilterWidget(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => setState(() => selectedOption = index),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
              color: selectedOption == index ? TraidColor.lightPurple : TraidColor.greyScaleLight,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            '${options[index]['label']} (${options[index]['count']})',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: selectedOption == index ? TraidColor.irisAccent : TraidColor.greyScale,
                ),
          ),
        ),
      ),
    );
  }
}
