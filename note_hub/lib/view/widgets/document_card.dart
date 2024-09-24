import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/model/document_model.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  final VoidCallback onTap;
  final VoidCallback editAction;
  final Function? imageOnTap;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
    required this.editAction,
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
          Image.network(
            document.icon,
            fit: BoxFit.contain,
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
          onTap: onTap,
          leading: GestureDetector(
            onTap: _showImage,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: GrayscaleGrayColors.lightGray,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Image.network(
                  document.icon,
                  fit: BoxFit.contain,
                ),
              ),
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
            onPressed: editAction,
            icon: Icon(Icons.edit, color: PrimaryColor.shade600),
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
          DateFormat("dd MM yyyy").format(dateOfUpload),
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
        Icon(
          CupertinoIcons.heart,
          size: AppTypography.body3.fontSize,
        ),
      ],
    );
  }
}
