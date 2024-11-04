import "package:flutter/material.dart";
import "package:get/get.dart";

import "package:notehub/controller/auth_controller.dart";

import "package:notehub/core/config/color.dart";

import "package:notehub/view/auth_screen/widget/login_form.dart";
import "package:notehub/view/auth_screen/widget/login_header.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(child: SizedBox.shrink()),
                  Center(child: LoginHeader()),
                  LoginForm(),
                ],
              ),
            ),
            GetX<AuthController>(
              builder: (controller) => controller.isLoading.value
                  ? Positioned.fill(
                      child: Container(
                        color: GrayscaleBlackColors.lightBlack.withOpacity(.5),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: OtherColors.tigerLily,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
