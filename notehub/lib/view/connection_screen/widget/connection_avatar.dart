import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notehub/core/config/color.dart';

class ConnectionAvatar extends StatelessWidget {
  const ConnectionAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      width: Get.width,
      height: 80,
      color: GrayscaleWhiteColors.darkWhite,
    );
  }
}
