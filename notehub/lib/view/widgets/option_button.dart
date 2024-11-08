import 'package:flutter/material.dart';
import 'package:notehub/core/config/color.dart';

class OptionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const OptionButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        side: BorderSide.none,
        padding: EdgeInsets.zero,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        foregroundColor: GrayscaleBlackColors.black,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
