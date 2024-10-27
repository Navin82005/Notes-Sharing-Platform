import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/profile_controller.dart';
import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/core/helper/custom_icon.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    return Container(
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
              _renderAvatar(profileController),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileController.profileData.value.displayName,
                    style: AppTypography.heading8,
                  ),
                  Text(
                    profileController.profileData.value.username,
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
    );
  }

  _renderAvatar(ProfileController controller) {
    return CircleAvatar(
      radius: 24,
      backgroundImage: NetworkImage(
        controller.profileData.value.profile == ""
            ? "https://ui-avatars.com/api/?name=${controller.profileData.value.displayName})"
            : controller.profileData.value.profile,
      ),
    );
  }
}
