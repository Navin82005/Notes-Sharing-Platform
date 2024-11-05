import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notehub/controller/profile_controller.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/model/document_model.dart';

class FollowButton extends StatefulWidget {
  final DocumentModel document;
  const FollowButton({super.key, required this.document});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    // return GetX<ProfileController>(
    // builder: (controller) {
    print("document.isFollowedByUser: ${widget.document.isFollowedByUser}");
    return TextButton(
      onPressed: () {
        Get.find<ProfileController>().follow(
          username: widget.document.username,
        );
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
            path: widget.document.isFollowedByUser
                ? "assets/icons/user-check.svg"
                : "assets/icons/user-plus.svg",
            size: AppTypography.subHead1.fontSize! + 2,
            color: OtherColors.amethystPurple,
          ),
          const SizedBox(width: 8),
          Text(
            _renderText(),
            style: AppTypography.subHead2.copyWith(
              color: OtherColors.amethystPurple,
            ),
          ),
        ],
      ),
    );
    // },
    // );
  }

  _renderText() {
    if (widget.document.isFollowedByUser) {
      return "Unfollow";
    }
    return "Follow";
  }
}
