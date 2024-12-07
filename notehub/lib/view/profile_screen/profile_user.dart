import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/profile_user_controller.dart';
import 'package:notehub/controller/showcase_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/model/user_model.dart';
import 'package:notehub/view/profile_screen/widget/follower_widget.dart';

import 'package:notehub/view/profile_screen/widget/profile_showcase.dart';
import 'package:notehub/view/widgets/primary_button.dart';
import 'package:notehub/view/widgets/refresher_widget.dart';
import 'package:notehub/view/widgets/secondary_button.dart';

import 'package:shimmer/shimmer.dart';

class ProfileUser extends StatefulWidget {
  final String username;
  const ProfileUser({super.key, required this.username});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  void initState() {
    super.initState();
    Get.put(ProfileUserController());
    Get.put(ShowcaseController(), tag: widget.username);
    loadUserData();
  }

  Future<void> loadUserData() async {
    Get.find<ProfileUserController>().fetchUserData(username: widget.username);
    Get.find<ShowcaseController>(tag: widget.username)
        .fetchProfilePosts(username: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: RefresherWidget(
        onRefresh: loadUserData,
        child: Column(
          children: [
            GetX<ProfileUserController>(
              builder: (controller) {
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: GrayscaleWhiteColors.almostWhite,
                    highlightColor: GrayscaleWhiteColors.white,
                    child: ProfileHeader(
                      profileData:
                          Get.find<ProfileUserController>().profileData.value,
                    ),
                  );
                }
                return ProfileHeader(
                  profileData:
                      Get.find<ProfileUserController>().profileData.value,
                );
              },
            ),
            ProfileShowcase(username: widget.username),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final UserModel profileData;
  const ProfileHeader({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          TopSection(profileData: profileData),
          const SizedBox(height: 24),
          ButtonSection(profileData: profileData),
        ],
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  final UserModel profileData;
  const TopSection({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
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
  final UserModel profileData;
  const ButtonSection({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: GetX<ProfileUserController>(builder: (controller) {
        return Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onTap: () {
                  controller.follow(username: profileData.username);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    !controller.profileData.value.isFollowedByUser
                        ? "Follow"
                        : "Un follow",
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
        );
      }),
    );
  }
}
