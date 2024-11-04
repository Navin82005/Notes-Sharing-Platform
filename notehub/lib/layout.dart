import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/bottom_navigation_controller.dart';
import 'package:notehub/controller/document_controller.dart';
import 'package:notehub/controller/profile_controller.dart';
import 'package:notehub/controller/showcase_controller.dart';

import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/model/user_model.dart';

import 'package:notehub/view/bottom_footer/bottom_footer.dart';

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
    Get.put(DocumentController());
    loadData();
  }

  void loadData() async {
    Get.find<ProfileController>().fetchUserData(username: HiveBoxes.username);
    // Get.find<ProfileController>()
    //     .fetchUserData(username: "navin82005@gmail.com");
    // HiveBoxes.userBox.put(
    //   "data",
    //   UserModel(
    //     displayName: "Naveen N",
    //     profile: '',
    //     username: "navin82005@gmail.com",
    //     institute: "Sri Shakthi Institute of Engineering Technology",
    //     followers: 10,
    //     following: 12,
    //     documents: 0,
    //   ),
    // );
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
