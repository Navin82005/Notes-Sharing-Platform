import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/auth_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';

import 'package:notehub/view/auth_screen/widget/login_fields.dart';
import 'package:notehub/view/widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryField(
          text: "Email",
          leadingIcon: const CustomIcon(path: "assets/icons/mail.svg"),
          controller: Get.find<AuthController>().emailEditingController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        PrimaryField(
          text: "Password",
          obscureText: true,
          leadingIcon: const CustomIcon(path: "assets/icons/lock.svg"),
          controller: Get.find<AuthController>().passwordEditingController,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          width: Get.width / 2,
          onTap: Get.find<AuthController>().loginWithEmail,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Login",
              style: AppTypography.heading6.copyWith(
                color: GrayscaleWhiteColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
