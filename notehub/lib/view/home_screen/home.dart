import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/document_controller.dart';
import 'package:notehub/controller/home_controller.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/view/home_screen/widget/home_document_section.dart';
import 'package:notehub/view/home_screen/widget/home_header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Get.put(DocumentController());
    Get.put(HomeController());
    loadData();
  }

  loadData() async {
    var homeController = Get.find<HomeController>();
    if (!homeController.isFetched.value) {
      homeController.fetchUpdates();
    }
    Get.find<DocumentController>().fetchDocsForUsername(
      username: HiveBoxes.username,
    );
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    if (!homeController.isFetched.value) {
      homeController.fetchUpdates();
    }
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SafeArea(child: SizedBox.shrink()),
            HomeHeader(),
            HomeDocumentSection(),
          ],
        ),
      ),
    );
  }
}
