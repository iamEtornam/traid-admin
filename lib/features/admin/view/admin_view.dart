import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traid_admin/components/custom_colors.dart';
import 'package:traid_admin/features/admin/cubit/admin_cubit.dart';
import 'package:traid_admin/features/admin/cubit/admin_state.dart';
import 'package:traid_admin/resources/resources.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final scrollController = ScrollController();
  List options = [];
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AdminCubit>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
        if (state is InitAdminState || state is LoadingAdminState) {
          return Center(
            child: CircularProgressIndicator(
              color: TraidColor.irisAccent,
            ),
          );
        } else if (state is ErrorAdminState) {
          return Center(child: Text(state.message));
        } else {
          final data = state as ResponseAdminState;
          final admins = data.admins;
          final totalTraider = admins.length;
          const totalGroups = 0;
          final totalRules =
              admins.map((e) => e.userRoles).expand((element) => element).toSet().length;
          options = options = [
            {'label': 'Traiders', 'count': totalTraider},
            {'label': 'Group', 'count': totalGroups},
            {'label': 'Rules', 'count': totalRules},
          ];
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Traiders',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: List.generate(
                        options.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: 32,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                    color: selectedOption == index
                                        ? TraidColor.lightPurple
                                        : TraidColor.greyScaleLight,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  '${options[index]['label']} (${options[index]['count']})',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: selectedOption == index
                                            ? TraidColor.irisAccent
                                            : TraidColor.greyScale,
                                      ),
                                ),
                              ),
                            )),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      controller: scrollController,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Add a New Traider 😊'),
                              SvgPicture.asset(
                                Svgs.add,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: ListView.separated(
                              shrinkWrap: true,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                final admin = admins[index];
                                final userRoles = admin.userRoles.join(", ");
                                final roles = userRoles.replaceAll('_', ' ');
                                final role = roles.isEmpty ? 'N/A' : roles;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: CachedNetworkImage(
                                          width: 40,
                                          height: 40,
                                          imageUrl: "http://via.placeholder.com/40x40",
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) => Center(
                                                  child: CircularProgressIndicator(
                                                      value: downloadProgress.progress)),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              admin.fullName,
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                            ),
                                            Text(
                                              '$role • ${admin.locale}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: TraidColor.greyScale),
                                            ),
                                            Container(
                                              width: 80,
                                              height: 26,
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 3),
                                              decoration: ShapeDecoration(
                                                color: admin.enabled
                                                    ? TraidColor.greenDark
                                                    : TraidColor.greyScale,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  admin.enabled ? 'Enabled' : 'Disabled',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
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
              ),
            ),
          );
        }
      }),
    );
  }
}