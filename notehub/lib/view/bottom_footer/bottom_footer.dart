import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/bottom_navigation_controller.dart';
import 'package:notehub/controller/profile_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/meta/app_meta.dart';

class BottomFooter extends StatelessWidget {
  const BottomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: GrayscaleWhiteColors.white,
        boxShadow: [
          BoxShadow(
            color: GrayscaleWhiteColors.darkWhite,
            spreadRadius: 1,
            blurRadius: 3,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GetX<BottomNavigationController>(
        builder: (controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  controller.currentPage.value = 0;
                  controller.update();
                },
                child: CustomIcon(
                  path: "assets/icons/house.svg",
                  color: controller.currentPage.value == 0
                      ? GrayscaleBlackColors.black
                      : GrayscaleGrayColors.shadedGray,
                  size: controller.currentPage.value != 0 ? 25 : 27,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.currentPage.value = 1;
                  controller.update();
                },
                child: CustomIcon(
                  path: "assets/icons/square-plus.svg",
                  size: controller.currentPage.value != 1 ? 25 : 27,
                  color: controller.currentPage.value == 1
                      ? GrayscaleBlackColors.black
                      : GrayscaleGrayColors.shadedGray,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.currentPage.value = 2;
                  controller.update();
                },
                child: CustomAvatar(
                  radius: controller.currentPage.value != 2 ? 15 : 17,
                  path: Get.find<ProfileController>()
                              .profileData
                              .value
                              .profile ==
                          "NA"
                      ? "${AppMetaData.avatar_url}&name=${Get.find<ProfileController>().profileData.value.displayName}"
                      : Get.find<ProfileController>().profileData.value.profile,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
