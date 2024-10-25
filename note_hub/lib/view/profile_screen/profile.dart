import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/profile_controller.dart';
import 'package:note_hub/controller/showcase_controller.dart';
import 'package:note_hub/core/helper/hive_boxes.dart';
import 'package:note_hub/view/profile_screen/widget/profile_header.dart';
import 'package:note_hub/view/profile_screen/widget/profile_showcase.dart';

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
    await Get.find<ProfileController>()
        .fetchUserData(username: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GetX<ProfileController>(builder: (controller) {
            if (controller.isLoading.value) {
              return const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return const ProfileHeader();
          }),
          ProfileShowcase(),
        ],
      ),
    );
  }
}
