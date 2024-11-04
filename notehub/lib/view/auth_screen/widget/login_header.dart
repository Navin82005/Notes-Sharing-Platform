import 'package:flutter/material.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          CustomIcon(
            path: "assets/icons/log-in.svg",
            size: 70,
            color: OtherColors.amethystPurple,
          ),
          const SizedBox(height: 12),
          Text("Login", style: AppTypography.heading4),
          const SizedBox(height: 8),
          Text(
            "Good to Have you Back!",
            style: AppTypography.subHead1.copyWith(
              color: GrayscaleGrayColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }
}
