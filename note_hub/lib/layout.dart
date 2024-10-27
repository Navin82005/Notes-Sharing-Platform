import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/bottom_navigation_controller.dart';
import 'package:note_hub/controller/profile_controller.dart';
import 'package:note_hub/controller/showcase_controller.dart';
import 'package:note_hub/core/helper/hive_boxes.dart';
import 'package:note_hub/model/user_model.dart';
import 'package:note_hub/view/bottom_footer/bottom_footer.dart';
import 'package:note_hub/view/home_screen/home.dart';
import 'package:note_hub/view/profile_screen/profile.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late BottomNavigationController bottomNavigationController;
  @override
  void initState() {
    super.initState();
    Get.put(ProfileController());
    Get.put(ShowcaseController());
    loadData();
  }

  void loadData() async {
    Get.find<ProfileController>()
        .fetchUserData(username: HiveBoxes.userBox.get("data")!.username);
    HiveBoxes.userBox.put(
      "data",
      UserModel(
        displayName: "Naveen N",
        profile: '',
        username: "navin82005@gmail.com",
        institute: "Sri Shakthi Institute of Engineering Technology",
        followers: 10,
        following: 12,
        documents: 0,
      ),
    );
    bottomNavigationController = Get.put(BottomNavigationController());
  }

  @override
  Widget build(BuildContext context) {
    return GetX<BottomNavigationController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: controller.page[controller.currentPage.value],
        bottomNavigationBar: const BottomFooter(),
      ),
    );
  }
}
