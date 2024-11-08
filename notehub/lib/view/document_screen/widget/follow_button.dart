import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/profile_user_controller.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';

import 'package:notehub/model/document_model.dart';

import 'package:notehub/view/widgets/loader.dart';

class FollowController extends GetxController {
  var isFollowedByUser = false.obs;
  var isLoading = false.obs;
}

class FollowButton extends StatefulWidget {
  final DocumentModel document;
  const FollowButton({super.key, required this.document});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  void initState() {
    super.initState();
    Get.put(FollowController());
    Get.find<FollowController>().isFollowedByUser.value =
        widget.document.isFollowedByUser;
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<FollowController>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<FollowController>(
      builder: (controller) {
        return Container(
          width: 120,
          child: TextButton(
            onPressed: () async {
              controller.isLoading.value = true;
              var res = await Get.find<ProfileUserController>().follow(
                username: widget.document.username,
                isProfile: false,
              );
              if (res) {
                controller.isFollowedByUser.value =
                    !controller.isFollowedByUser.value;
                widget.document.isFollowedByUser =
                    !widget.document.isFollowedByUser;
              }
              controller.isLoading.value = false;
            },
            style: const ButtonStyle().copyWith(
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIcon(
                  path: controller.isFollowedByUser.value
                      ? "assets/icons/user-check.svg"
                      : "assets/icons/user-plus.svg",
                  size: AppTypography.subHead1.fontSize! + 2,
                  color: OtherColors.amethystPurple,
                ),
                const Spacer(),
                if (controller.isLoading.value)
                  Loader2(
                    size: AppTypography.subHead1.fontSize! - 2,
                    strokeWidth: 1,
                  )
                else
                  Text(
                    _renderText(),
                    style: AppTypography.subHead2.copyWith(
                      color: OtherColors.amethystPurple,
                    ),
                  ),
                const Spacer(),
                // if (controller.isLoading.value) const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  _renderText() {
    if (widget.document.isFollowedByUser) {
      return "Unfollow";
    }
    return "Follow";
  }
}
