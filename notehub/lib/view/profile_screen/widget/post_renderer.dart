import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notehub/controller/showcase_controller.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/helper/hive_boxes.dart';
import 'package:notehub/model/document_model.dart';
import 'package:notehub/view/widgets/document_card.dart';
import 'package:shimmer/shimmer.dart';

class PostsRenderer extends StatelessWidget {
  final List<DocumentModel> posts;
  final String usernameTag;
  const PostsRenderer(
      {super.key, required this.posts, required this.usernameTag});

  @override
  Widget build(BuildContext context) {
    return GetX<ShowcaseController>(
      tag: usernameTag,
      builder: (controller) {
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
        } else {
          return Container(
            margin: const EdgeInsets.only(top: 15),
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return DocumentCard(
                  document: posts[index],
                  actionType: posts[index].username == HiveBoxes.username
                      ? ActionType.edit
                      : ActionType.more,
                );
              },
            ),
          );
        }
      },
    );
  }
}
