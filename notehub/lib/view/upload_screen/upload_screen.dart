import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/upload_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';

import 'package:notehub/view/upload_screen/widget/upload_form.dart';
import 'package:notehub/view/widgets/loader.dart';
import 'package:notehub/view/widgets/primary_button.dart';
import 'package:notehub/view/widgets/secondary_button.dart';

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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Stack(
                children: [
                  Column(
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
                ],
              ),
            ),
            GetX<UploadController>(
              builder: (controller) {
                if (controller.isLoading.value) {
                  return Positioned.fill(
                    child: Container(
                      color: GrayscaleWhiteColors.darkWhite.withOpacity(.5),
                      child: const Center(child: Loader()),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
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
