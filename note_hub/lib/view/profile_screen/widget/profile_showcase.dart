import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/profile_controller.dart';

import 'package:note_hub/core/config/color.dart';
import 'package:note_hub/core/helper/custom_icon.dart';

import 'package:note_hub/controller/showcase_controller.dart';
import 'package:note_hub/core/helper/hive_boxes.dart';
import 'package:note_hub/model/document_model.dart';

import 'package:note_hub/view/widgets/document_card.dart';
import 'package:open_file/open_file.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShowcase extends StatelessWidget {
  const ProfileShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: GrayscaleBlackColors.tintedBlack,
              labelColor: GrayscaleBlackColors.black,
              unselectedLabelColor: GrayscaleGrayColors.silver,
              tabs: const [
                Tab(
                  icon: CustomIcon(path: "assets/icons/book.svg"),
                ),
                Tab(
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

class PostsRenderer extends StatelessWidget {
  final List<DocumentModel> posts;
  const PostsRenderer({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GetX<ShowcaseController>(builder: (controller) {
      if (controller.isLoading.value) {
        // return const Center(child: CircularProgressIndicator());
        return Container(
          margin: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: GrayscaleWhiteColors.almostWhite,
                highlightColor: GrayscaleWhiteColors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  height: 100,
                  width: Get.width,
                ),
              );
              // DocumentCard(
              //   document: posts[index],
              //   actionType:
              //       Get.find<ProfileController>().profileData.value.username ==
              //               HiveBoxes.userBox.get("data")!.username
              //           ? ActionType.edit
              //           : ActionType.more,
              // );
            },
          ),
        );
      }
      if (posts.isEmpty) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CustomIcon(path: "assets/icons/files.svg")),
            SizedBox(height: 10),
            Center(child: Text("No Documents to Display")),
          ],
        );
      }
      return Container(
        margin: const EdgeInsets.only(top: 15),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return DocumentCard(
              document: posts[index],
              actionType:
                  Get.find<ProfileController>().profileData.value.username ==
                          HiveBoxes.userBox.get("data")!.username
                      ? ActionType.edit
                      : ActionType.more,
            );
          },
        ),
      );
    });
  }
}
