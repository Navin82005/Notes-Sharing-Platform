import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import 'package:note_hub/controller/upload_controller.dart';

import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/core/helper/custom_icon.dart';

import 'package:note_hub/view/upload_screen/widget/upload_button.dart';
import 'package:note_hub/view/widgets/upload_text_field.dart';

class UploadForm extends StatelessWidget {
  const UploadForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<UploadController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderDocumentUploadSection(controller),
          const SizedBox(height: 12),
          _renderCoverUploadSection(controller),
          const SizedBox(height: 24),
          UploadTextField(
            text: "Name",
            controller: controller.nameEditingController,
          ),
          const SizedBox(height: 12),
          UploadTextField(
            text: "Topic",
            controller: controller.topicEditingController,
          ),
          const SizedBox(height: 12),
          UploadTextArea(
            text: "Description",
            controller: controller.descriptionEditingController,
          ),
        ],
      );
    });
  }

  _renderDocumentUploadSection(UploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Document", style: AppTypography.subHead1),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (controller.selectedDocument.value != null)
                  CustomIcon(
                    path: "assets/icons/files.svg",
                    color: OtherColors.amethystPurple,
                  )
                else
                  CustomIcon(
                    path: "assets/icons/files.svg",
                    color: GrayscaleGrayColors.paleGray,
                  ),
                const SizedBox(width: 8),
                if (controller.selectedDocument.value != null)
                  SizedBox(
                    width: Get.width / 2,
                    child: GestureDetector(
                      onTap: () {
                        OpenFile.open(controller.selectedDocument.value!.path);
                      },
                      child: Text(
                        controller.selectedDocument.value!.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body2.copyWith(
                          color: OtherColors.amethystPurple,
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    "No file chosen",
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body2.copyWith(
                      color: GrayscaleGrayColors.paleGray,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            if (controller.selectedDocument.value == null)
              const UploadButton(text: "Select", state: "document")
            else
              const UploadButton(text: "Edit", state: "document")
          ],
        )
      ],
    );
  }

  _renderCoverUploadSection(UploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cover Image", style: AppTypography.subHead1),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (controller.selectedCover.value != null)
                  CustomIcon(
                    path: "assets/icons/files.svg",
                    color: OtherColors.amethystPurple,
                  )
                else
                  CustomIcon(
                    path: "assets/icons/files.svg",
                    color: GrayscaleGrayColors.paleGray,
                  ),
                const SizedBox(width: 8),
                if (controller.selectedCover.value != null)
                  SizedBox(
                    width: Get.width / 2,
                    child: GestureDetector(
                      onTap: () {
                        OpenFile.open(controller.selectedCover.value!.path);
                      },
                      child: Text(
                        controller.selectedCover.value!.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body2.copyWith(
                          color: OtherColors.amethystPurple,
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    "No file chosen",
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body2.copyWith(
                      color: GrayscaleGrayColors.paleGray,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            if (controller.selectedCover.value == null)
              const UploadButton(text: "Select", state: "cover")
            else
              const UploadButton(text: "Edit", state: "cover")
          ],
        )
      ],
    );
  }
}
