import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';

class PrimaryButton extends StatelessWidget {
  final Color? color;
  final String? text;

  final VoidCallback? onTap;

  final TextStyle? textStyle;
  final Widget? child;

  final double? borderRadius;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    this.color,
    this.text,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.textStyle,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color ?? OtherColors.amethystPurple,
      ),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          onPressed: onTap,
          child: Center(
            child: child ??
                Text(
                  text!,
                  style: textStyle ??
                      AppTypography.subHead3.copyWith(
                        color: GrayscaleBlackColors.black,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}
