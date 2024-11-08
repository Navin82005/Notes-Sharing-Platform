import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/profile_controller.dart';
import 'package:notehub/controller/showcase_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/view/profile_screen/widget/profile_header.dart';
import 'package:notehub/view/profile_screen/widget/profile_showcase.dart';
import 'package:notehub/view/settings_screen/settings_drawer.dart';
import 'package:notehub/view/widgets/normal_button.dart';
import 'package:notehub/view/widgets/refresher_widget.dart';

import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  final String username;
  const Profile({super.key, required this.username});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Get.put(SettingsDrawerController());
    loadUserData();
  }

  Future<void> loadUserData() async {
    Get.put(SettingsDrawerController());
    Get.find<ProfileController>().fetchUserData(username: HiveBoxes.username);
    Get.find<ShowcaseController>(tag: HiveBoxes.username)
        .fetchProfilePosts(username: HiveBoxes.username);
    Get.find<ShowcaseController>(tag: HiveBoxes.username)
        .fetchSavedPosts(username: HiveBoxes.username);
  }

  @override
  Widget build(BuildContext context) {
    return RefresherWidget(
      onRefresh: loadUserData,
      child: Scaffold(
        key: Get.find<SettingsDrawerController>().scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: const SettingsDrawer(),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NormalButton(
                  onPressed: Get.find<SettingsDrawerController>().openDrawer,
                  child: const CustomIcon(path: "assets/icons/settings.svg"),
                ),
                const SizedBox(width: 24),
              ],
            ),
            GetX<ProfileController>(builder: (controller) {
              if (controller.isLoading.value) {
                return Shimmer.fromColors(
                  baseColor: GrayscaleWhiteColors.almostWhite,
                  highlightColor: GrayscaleWhiteColors.white,
                  child: ProfileHeader(
                    profileData:
                        Get.find<ProfileController>().profileData.value,
                  ),
                );
              }
              return ProfileHeader(
                profileData: Get.find<ProfileController>().profileData.value,
              );
            }),
            ProfileShowcase(username: widget.username),
          ],
        ),
      ),
    );
  }
}
