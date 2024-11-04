import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/upload_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';

import 'package:notehub/view/widgets/primary_button.dart';

class UploadButton extends StatelessWidget {
  final String text;
  final String state;
  const UploadButton({super.key, required this.text, required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PrimaryButton(
        onTap: () {
          if (state == "cover") {
            Get.find<UploadController>().pickCover();
          } else if (state == "document") {
            Get.find<UploadController>().pickDocument();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: AppTypography.body2.copyWith(
              color: GrayscaleWhiteColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
