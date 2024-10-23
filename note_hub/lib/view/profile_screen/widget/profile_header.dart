import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/core/helper/custom_icon.dart';

import 'package:note_hub/controller/profile_controller.dart';

import 'package:note_hub/view/profile_screen/widget/follower_widget.dart';
import 'package:note_hub/view/widgets/primary_button.dart';
import 'package:note_hub/view/widgets/secondary_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: const Column(
        children: [
          TopSection(),
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
              _renderAvatar(profileData.profile),
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

  _renderAvatar(profile) {
    if (profile != "") {
      return CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(profile),
      );
    } else {
      return const CircleAvatar(
        radius: 40,
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
              height: 40,
              text: "Edit profile",
              textStyle: AppTypography.subHead3.copyWith(
                color: GrayscaleWhiteColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SecondaryButton(
            width: Get.width / 8,
            height: 40,
            child: CustomIcon(
              path: "assets/icons/send.svg",
              size: 20,
              color: GrayscaleBlackColors.lightBlack,
            ),
          ),
        ],
      ),
    );
  }
}
