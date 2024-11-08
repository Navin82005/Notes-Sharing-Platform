import 'package:flutter/material.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _renderTile(() {}, ""),
      ],
    );
  }

  _renderTile(VoidCallback onTap, String placeholder) {
    return;
  }
}
