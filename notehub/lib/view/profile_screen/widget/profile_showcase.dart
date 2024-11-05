import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notehub/view/profile_screen/widget/post_renderer.dart';
import 'package:shimmer/shimmer.dart';

import 'package:notehub/controller/profile_controller.dart';
import 'package:notehub/controller/showcase_controller.dart';

import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/model/document_model.dart';

import 'package:notehub/view/widgets/document_card.dart';

class ProfileShowcase extends StatelessWidget {
  final String? username;
  const ProfileShowcase({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: HiveBoxes.username == username ? 2 : 1,
        child: Column(
          children: [
            TabBar(
              indicatorColor: GrayscaleBlackColors.tintedBlack,
              labelColor: GrayscaleBlackColors.black,
              unselectedLabelColor: GrayscaleGrayColors.silver,
              tabs: [
                const Tab(
                  icon: CustomIcon(path: "assets/icons/book.svg"),
                ),
                if (HiveBoxes.username == username)
                  const Tab(
                    icon: CustomIcon(path: "assets/icons/bookmark.svg"),
                  ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PostsRenderer(
                    posts: Get.find<ShowcaseController>().profilePosts,
                  ),
                  if (HiveBoxes.username == username)
                    PostsRenderer(
                      posts: Get.find<ShowcaseController>().savedPosts,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
