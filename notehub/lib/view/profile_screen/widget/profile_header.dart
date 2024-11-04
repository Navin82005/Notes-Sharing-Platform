import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';

import 'package:notehub/controller/profile_controller.dart';

import 'package:notehub/view/profile_screen/widget/follower_widget.dart';
import 'package:notehub/view/widgets/primary_button.dart';
import 'package:notehub/view/widgets/secondary_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: const Column(
        children: [
          TopSection(),
          SizedBox(height: 24),
          ButtonSection(),
        ],
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    var profileData = Get.find<ProfileController>().profileData.value;
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _renderAvatar(profileData.profile, profileData.displayName),
              const Spacer(),
              FollowerWidget(
                data: profileData.documents.toString(),
                display: "documents",
              ),
              FollowerWidget(
                data: profileData.followers.toString(),
                display: "followers",
              ),
              FollowerWidget(
                data: profileData.following.toString(),
                display: "following",
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text("${profileData.displayName} ", style: AppTypography.subHead1),
          Text("${profileData.institute} ", style: AppTypography.body3),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _renderAvatar(profile, name) {
    if (profile != "") {
      return CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(profile),
      );
    } else {
      return CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage("https://ui-avatars.com/api/?name=$name"),
      );
    }
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Edit profile",
                  style: AppTypography.subHead3.copyWith(
                    color: GrayscaleWhiteColors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SecondaryButton(
            width: Get.width / 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: CustomIcon(
                path: "assets/icons/send.svg",
                size: 20,
                color: GrayscaleBlackColors.lightBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
