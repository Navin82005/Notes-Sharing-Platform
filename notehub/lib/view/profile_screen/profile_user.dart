import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/profile_user_controller.dart';
import 'package:notehub/controller/showcase_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/view/profile_screen/widget/profile_header.dart';
import 'package:notehub/view/profile_screen/widget/profile_showcase.dart';
import 'package:notehub/view/widgets/refresher_widget.dart';

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
    loadUserData();
  }

  Future<void> loadUserData() async {
    print("HiveBoxes.username: ${HiveBoxes.username}");
    print("widget.username: ${widget.username}");
    Get.find<ProfileUserController>().fetchUserData(username: widget.username);
    Get.find<ShowcaseController>().fetchProfilePosts(username: widget.username);
    Get.find<ShowcaseController>().fetchSavedPosts(username: widget.username);
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
