import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/meta/app_meta.dart';
import 'package:notehub/model/mini_user_model.dart';
import 'package:notehub/view/connection_screen/widget/more_options.dart';
import 'package:notehub/view/profile_screen/profile_user.dart';
import 'package:notehub/view/widgets/secondary_button.dart';

class ConnectionAvatar extends StatelessWidget {
  final MiniUserModel? user;
  const ConnectionAvatar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        width: Get.width,
        height: 80,
        color: GrayscaleWhiteColors.darkWhite,
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: Get.width,
      // height: 80,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          side: BorderSide.none,
          padding: EdgeInsets.zero,
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero,
          foregroundColor: GrayscaleBlackColors.black,
        ),
        onPressed: () {
          Get.to(() => ProfileUser(username: user!.username));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              const SizedBox(width: 12),
              CustomAvatar(path: _getProfileUrl()),
              const SizedBox(width: 16),
              _renderLabels(),
              const Spacer(),
              _renderOptions(),
            ],
          ),
        ),
      ),
    );
  }

  _getProfileUrl() {
    if (user!.profile == "NA") {
      return "${AppMetaData.avatar_url}&name=${user!.displayName}";
    } else {
      return user!.profile;
    }
  }

  _renderLabels() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user!.displayName, style: AppTypography.body1),
        SizedBox(
          width: Get.width / 1.5,
          child: Text(user!.institute, style: AppTypography.body4),
        ),
      ],
    );
  }

  _renderOptions() {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(const MoreOptions());
      },
      icon: const CustomIcon(path: "assets/icons/ellipsis-vertical.svg"),
    );
  }
}
