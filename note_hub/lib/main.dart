import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/core/meta/app_meta.dart';
import 'package:note_hub/view/home_screen/home.dart';
import 'package:note_hub/view/splash_screen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "${AppMetaData.appName} | Home",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
