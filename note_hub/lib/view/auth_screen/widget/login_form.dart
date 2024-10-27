import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/auth_controller.dart';
import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/core/helper/custom_icon.dart';
import 'package:note_hub/view/auth_screen/widget/login_fields.dart';
import 'package:note_hub/view/widgets/primary_button.dart';

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
