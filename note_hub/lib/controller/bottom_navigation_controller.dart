import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/view/home_screen/home.dart';
import 'package:note_hub/view/profile_screen/profile.dart';
import 'package:note_hub/view/upload_screen/upload_screen.dart';

class BottomNavigationController extends GetxController {
  var currentPage = 0.obs;

  List<Widget> page = [
    Home(),
    const UploadScreen(),
    const Profile(),
  ];
}
