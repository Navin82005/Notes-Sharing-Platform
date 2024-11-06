import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class Loader2 extends StatelessWidget {
  final double? size;
  final double? padding;
  final double? strokeWidth;
  const Loader2({super.key, this.size, this.padding, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(strokeWidth: strokeWidth ?? 2),
      ),
    );
  }
}
