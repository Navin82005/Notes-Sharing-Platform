import 'package:flutter/material.dart';
import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';

class UploadTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  const UploadTextField({
    super.key,
    this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTypography.body2,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
        label: Text(
          text,
          style: AppTypography.body2.copyWith(
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
      ),
    );
  }
}

class UploadTextArea extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  const UploadTextArea({super.key, required this.text, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 10,
      minLines: 5,
      keyboardType: TextInputType.multiline,
      controller: controller,
      style: AppTypography.body2,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
        label: Text(
          text,
          style: AppTypography.body2.copyWith(
            color: GrayscaleBlackColors.lightBlack,
          ),
        ),
      ),
    );
  }
}
