import 'package:flutter/material.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/helper/hive_boxes.dart';
import 'package:notehub/model/document_model.dart';
import 'package:notehub/view/document_screen/widget/follow_button.dart';

class Document extends StatelessWidget {
  final DocumentModel document;
  const Document({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: GrayscaleGrayColors.lightGray,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _renderHeader(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _renderHeader() {
    print(document.icon);
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomAvatar(path: document.profile),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(document.displayName, style: AppTypography.subHead1),
            Text(document.username, style: AppTypography.body4),
          ],
        ),
        const Spacer(),
        if (HiveBoxes.username != document.username)
          FollowButton(document: document)
        else
          CustomIcon(
            path: "assets/icons/pen.svg",
            size: AppTypography.subHead1.fontSize! + 2,
          ),
      ],
    );
  }
}
