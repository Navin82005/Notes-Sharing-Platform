import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  const NormalButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
    );
  }
}
