import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/view/home_screen/home.dart';
import 'package:notehub/view/profile_screen/profile.dart';
import 'package:notehub/view/upload_screen/upload_screen.dart';

class BottomNavigationController extends GetxController {
  var currentPage = 0.obs;

  List<Widget> page = [
    const Home(),
    const UploadScreen(),
    Profile(username: HiveBoxes.username),
  ];
}
