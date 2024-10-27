import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_hub/controller/upload_controller.dart';

import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/config/typography.dart';
import 'package:note_hub/core/helper/custom_icon.dart';

import 'package:note_hub/view/upload_screen/widget/upload_form.dart';
import 'package:note_hub/view/widgets/primary_button.dart';
import 'package:note_hub/view/widgets/secondary_button.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    Get.put(UploadController());
    Get.find<UploadController>().clearForm();
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<UploadController>().clearForm();
    Get.find<UploadController>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              CustomIcon(
                path: "assets/icons/cloud-upload.svg",
                size: 128,
                color: OtherColors.amethystPurple,
              ),
              Text("Upload a Note", style: AppTypography.heading8),
              const SizedBox(height: 48),
              const UploadForm(),
              const Spacer(),
              const UploadFooter()
            ],
          ),
        ),
      ),
    );
  }
}

class UploadFooter extends StatelessWidget {
  const UploadFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            onTap: () {
              Get.find<UploadController>().uploadDocument();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Upload",
                style: AppTypography.body2.copyWith(
                  color: GrayscaleWhiteColors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SecondaryButton(
          onTap: () {
            Get.find<UploadController>().clearForm();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "Clear",
              style: AppTypography.body2.copyWith(
                color: GrayscaleBlackColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
