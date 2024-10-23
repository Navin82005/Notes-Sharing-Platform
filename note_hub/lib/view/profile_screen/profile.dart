import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/profile_controller.dart';
import 'package:note_hub/controller/showcase_controller.dart';
import 'package:note_hub/view/profile_screen/widget/profile_header.dart';
import 'package:note_hub/view/profile_screen/widget/profile_showcase.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ProfileHeader(),
          ProfileShowcase(),
        ],
      ),
    );
  }
}
