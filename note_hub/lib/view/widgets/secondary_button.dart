import 'package:flutter/material.dart';

import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';

class SecondaryButton extends StatelessWidget {
  final String? text;

  final VoidCallback? onTap;

  final Color? color;
  final TextStyle? textStyle;
  final Widget? child;
  final Border? border;

  final double? borderRadius;
  final double? width;
  final double? height;

  const SecondaryButton({
    super.key,
    this.color,
    this.text,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.textStyle,
    this.child,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: border ??
            Border.all(
              width: 1,
              color: GrayscaleBlackColors.lightBlack,
            ),
      ),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: EdgeInsets.zero,
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
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
