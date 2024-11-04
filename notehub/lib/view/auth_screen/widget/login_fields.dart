import 'package:flutter/material.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';

class PrimaryField extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? leadingIcon;
  final TextInputType? keyboardType;

  const PrimaryField({
    super.key,
    required this.text,
    this.controller,
    this.obscureText,
    this.leadingIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTypography.body2,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        icon: leadingIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleGrayColors.lightGray,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleGrayColors.lightGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleGrayColors.lightGray,
          ),
        ),
        label: Text(
          text,
          style: AppTypography.body2.copyWith(
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
      ),
      obscureText: obscureText ?? false,
    );
  }
}
