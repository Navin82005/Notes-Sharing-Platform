import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/core/helper/custom_icon.dart';
import 'package:note_hub/model/document_model.dart';
import 'package:note_hub/service/file_caching.dart';

enum ActionType { edit, more }

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  final VoidCallback? onTap;
  final VoidCallback? action;
  final Function? imageOnTap;
  final ActionType actionType;

  const DocumentCard({
    super.key,
    required this.document,
    this.onTap,
    this.action,
    required this.actionType,
    this.imageOnTap,
  });

  _showImage() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.close, color: DangerColors.shade500),
            ),
          ),
          document.icon == ""
              ? const CustomIcon(path: "assets/icons/files.svg")
              : Image.network(
                  document.icon,
                  fit: BoxFit.contain,
                  width: Get.width,
                  height: Get.height / 1.5,
                ),
        ],
      ),
      transitionDuration: Duration.zero,
      transitionCurve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: GrayscaleWhiteColors.white,
          boxShadow: [
            BoxShadow(
              color: GrayscaleWhiteColors.almostWhite,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ListTile(
          onTap: () {
            onTap == null
                ? saveAndOpenFile(
                    uri: document.document,
                    name: document.documentName,
                  )
                : onTap!();
          },
          leading: GestureDetector(
            onTap: () {
              if (document.icon != "") {
                _showImage();
              }
            },
            child: document.icon == ""
                ? const CustomIcon(path: "assets/icons/files.svg")
                : Image.network(
                    document.icon,
                    fit: BoxFit.cover,
                    width: 50,
                  ),
          ),
          title: Text(document.name, style: AppTypography.subHead1),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: DocumentFooter(
              topic: document.topic,
              likes: document.likes,
              dateOfUpload: document.dateOfUpload,
            ),
          ),
          trailing: IconButton(
            onPressed: action,
            icon: actionType == ActionType.edit
                ? Icon(Icons.edit, color: PrimaryColor.shade600)
                : const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}

class DocumentFooter extends StatelessWidget {
  final String topic;
  final int likes;
  final DateTime dateOfUpload;
  const DocumentFooter(
      {super.key,
      required this.topic,
      required this.likes,
      required this.dateOfUpload});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          topic,
          style: AppTypography.body3.copyWith(
            color: GrayscaleGrayColors.lightGray,
          ),
        ),
        LikesWithHeart(likes: likes),
        Text(
          DateFormat("d/M/yyyy").format(dateOfUpload),
          style: AppTypography.body3.copyWith(
            color: GrayscaleGrayColors.lightGray,
          ),
        ),
      ],
    );
  }
}

class LikesWithHeart extends StatelessWidget {
  final int likes;
  const LikesWithHeart({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          likes.toString(),
          style: AppTypography.body3.copyWith(
            color: GrayscaleGrayColors.lightGray,
          ),
        ),
        const SizedBox(width: 4),
        CustomIcon(
          path: "assets/icons/heart-solid.svg",
          size: AppTypography.body3.fontSize,
          color: Colors.red[300],
        ),
      ],
    );
  }
}
