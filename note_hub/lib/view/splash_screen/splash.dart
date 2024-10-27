import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/core/helper/hive_boxes.dart';
import 'package:note_hub/core/meta/app_meta.dart';
import 'package:note_hub/layout.dart';
import 'package:note_hub/view/auth_screen/login.dart';
import 'package:note_hub/view/onboarding_screen/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  _redirect() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.off(() =>
        HiveBoxes.userBox.containsKey("data") ? const Layout() : const Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor.shade600,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/animations/notes.json",
            height: 300,
            width: 300,
            alignment: Alignment.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("", style: AppTypography.heading1),
              AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    AppMetaData.appName,
                    textStyle:
                        AppTypography.heading1.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
