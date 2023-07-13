import 'dart:math';

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

  final images = [
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1064&q=80',
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
    'https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
    'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
    'https://images.unsplash.com/photo-1488161628813-04466f872be2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1064&q=80',
    'https://images.unsplash.com/photo-1519058082700-08a0b56da9b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
    'https://images.unsplash.com/photo-1590086782792-42dd2350140d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
    'https://images.unsplash.com/photo-1596075780750-81249df16d19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
  ];

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                    options.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => setState(() => selectedOption = index),
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
                          Text(
                            'Add a New Traider 😊',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
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
                                      imageUrl: images[Random().nextInt(images.length)],
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress.progress)),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          admin.fullName,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          '$role • ${admin.locale}',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
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
          );
        }
      }),
    );
  }
}
