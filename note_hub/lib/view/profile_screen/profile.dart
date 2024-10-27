import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/profile_controller.dart';
import 'package:note_hub/controller/showcase_controller.dart';
import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/helper/hive_boxes.dart';
import 'package:note_hub/view/profile_screen/widget/profile_header.dart';
import 'package:note_hub/view/profile_screen/widget/profile_showcase.dart';
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
    Get.find<ProfileController>().fetchUserData(username: widget.username);
    Get.find<ShowcaseController>()
        .fetchProfilePosts(username: HiveBoxes.userBox.get("data")!.username);
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
