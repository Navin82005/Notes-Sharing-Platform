import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/profile_controller.dart';
import 'package:notehub/controller/showcase_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/view/profile_screen/widget/profile_header.dart';
import 'package:notehub/view/profile_screen/widget/profile_showcase.dart';

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
    loadUserData();
  }

  loadUserData() async {
    print("HiveBoxes.username: ${HiveBoxes.username}");
    print("widget.username: ${widget.username}");
    Get.find<ProfileController>().fetchUserData(username: HiveBoxes.username);
    Get.find<ShowcaseController>()
        .fetchProfilePosts(username: HiveBoxes.username);
    // .fetchProfilePosts(username: "navin82005@gmail.com");
  }

  @override
  Widget build(BuildContext context) {
    loadUserData(); // TODO Remove in production
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          GetX<ProfileController>(builder: (controller) {
            if (controller.isLoading.value) {
              return Shimmer.fromColors(
                baseColor: GrayscaleWhiteColors.almostWhite,
                highlightColor: GrayscaleWhiteColors.white,
                child: const ProfileHeader(),
              );
            }
            return const ProfileHeader();
          }),
          const ProfileShowcase(),
        ],
      ),
    );
  }
}
