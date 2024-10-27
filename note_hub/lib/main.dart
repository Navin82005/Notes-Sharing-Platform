import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_hub/controller/bottom_navigation_controller.dart';
import 'package:note_hub/core/helper/hive_boxes.dart';

import 'package:note_hub/core/meta/app_meta.dart';

import 'package:note_hub/layout.dart';

import 'package:note_hub/model/user_model.dart';
import 'package:note_hub/view/auth_screen/login.dart';

import 'package:note_hub/view/splash_screen/splash.dart';
import 'package:toastification/toastification.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>("user");

  Get.put(BottomNavigationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "${AppMetaData.appName} | Home",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splash(),
        // home: HiveBoxes.userBox.containsKey("data")
        //     ? const Layout()
        //     : const Login(),
      ),
    );
  }
}
