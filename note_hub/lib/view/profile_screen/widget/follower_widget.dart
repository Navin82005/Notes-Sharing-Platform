import 'package:flutter/cupertino.dart';
import 'package:note_hub/core/config/typography.dart';

class FollowerWidget extends StatelessWidget {
  final String data;
  final String display;
  const FollowerWidget({super.key, required this.data, required this.display});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(data, style: AppTypography.subHead1),
          Text(display, style: AppTypography.subHead3)
        ],
      ),
    );
  }
}
