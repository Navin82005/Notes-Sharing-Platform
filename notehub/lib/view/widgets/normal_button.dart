import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NormalButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final double? width;
  const NormalButton({
    super.key,
    this.onPressed,
    required this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: const ButtonStyle().copyWith(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        child: child,
      ),
    );
  }
}
