import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:notehub/controller/bottom_navigation_controller.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/model/user_model.dart';

import 'package:notehub/view/splash_screen/splash.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>("user");
  Get.put(BottomNavigationController());
  print("HiveUserBox ${Hive.box<UserModel>("user")}");
  print("HiveUserBox ${HiveBoxes.userBox.containsKey('data')}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Note Hub',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
