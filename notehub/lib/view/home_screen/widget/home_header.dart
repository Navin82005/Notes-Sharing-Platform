import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/profile_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/meta/app_meta.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: GrayscaleWhiteColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _renderAvatar(controller),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.profileData.value.displayName,
                      style: AppTypography.heading8,
                    ),
                    Text(
                      controller.profileData.value.username,
                      style: AppTypography.subHead3.copyWith(
                        color: GrayscaleBlackColors.lightBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CustomIcon(path: "assets/icons/bell.svg"),
            )
          ],
        ),
      ),
    );
  }

  _renderAvatar(ProfileController controller) {
    print("Color Code: ${OtherColors.amethystPurple.value}");
    print(
        "${AppMetaData.avatar_url}&name=${controller.profileData.value.displayName}");
    return CircleAvatar(
      radius: 24,
      backgroundImage: NetworkImage(
        controller.profileData.value.profile == "NA"
            ? "${AppMetaData.avatar_url}&name=${controller.profileData.value.displayName}"
            : controller.profileData.value.profile,
      ),
    );
  }
}
