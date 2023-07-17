import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:traid_admin/components/custom_colors.dart';
import 'package:traid_admin/models/admin.dart';

class TraiderListTileWidget extends StatelessWidget {
  const TraiderListTileWidget({
    super.key,
    required this.images,
    required this.admin,
    required this.role,
  });

  final List<String> images;
  final Admin admin;
  final String role;

  @override
  Widget build(BuildContext context) {
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
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
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
                const SizedBox(height: 4),
                Text(
                  '$role • ${admin.locale}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500, color: TraidColor.greyScale),
                ),
                Container(
                  width: 80,
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: ShapeDecoration(
                    color: admin.enabled ? TraidColor.greenDark : TraidColor.greyScale,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Center(
                    child: Text(
                      admin.enabled ? 'Enabled' : 'Disabled',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
  }
}
