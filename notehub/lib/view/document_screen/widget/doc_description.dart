import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notehub/controller/document_controller.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';

import 'package:notehub/model/document_model.dart';
import 'package:notehub/view/document_screen/widget/icon_viewer.dart';
import 'package:notehub/view/widgets/loader.dart';

class LikeController extends GetxController {
  var isLiked = false.obs;
  var isLoading = false.obs;
}

class BookmarkController extends GetxController {
  var isBookmarked = false.obs;
  var isLoading = false.obs;
}

class DocDescription extends StatefulWidget {
  final DocumentModel document;
  const DocDescription({super.key, required this.document});

  @override
  State<DocDescription> createState() => _DocDescriptionState();
}

class _DocDescriptionState extends State<DocDescription> {
  @override
  void initState() {
    Get.put(LikeController());
    Get.find<LikeController>().isLiked.value = widget.document.isLiked;
    Get.put(BookmarkController());
    Get.find<BookmarkController>().isBookmarked.value =
        widget.document.isBookmarked;
    super.initState();
  }

  @override
  void dispose() {
    Get.find<LikeController>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.document.name, style: AppTypography.heading8),
        const SizedBox(height: 12),
        _renderDescription(),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Get.to(
            () => IconViewer(
              image: widget.document.icon,
              name: widget.document.iconName,
            ),
          ),
          child: Hero(
            tag: "IconViewer: ${widget.document.icon}",
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.document.icon,
              height: 250,
              width: Get.width,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _renderFooter(),
      ],
    );
  }

  _renderDescription() {
    final RegExp pattern = RegExp(r"#\w+");

    final List<TextSpan> spans = [];
    widget.document.description.trim().splitMapJoin(
      pattern,
      onMatch: (match) {
        spans.add(
          TextSpan(
            text: match[0]!,
            style: AppTypography.body1.copyWith(
              color: OtherColors.amethystPurple,
            ),
          ),
        );
        return match[0]!;
      },
      onNonMatch: (nonMatch) {
        spans.add(
          TextSpan(
            text: nonMatch,
            style: AppTypography.body1.copyWith(
              color: GrayscaleBlackColors.black,
            ),
          ),
        );
        return nonMatch;
      },
    );

    return RichText(text: TextSpan(children: spans));
  }

  _renderFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 8, right: 8),
      child: GetX<LikeController>(builder: (controller) {
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                controller.isLoading.value = true;
                if (controller.isLiked.value) {
                  await Get.find<DocumentController>().likeDislikeDocument(
                      documentId: widget.document.documentId, mode: "dislike");
                  widget.document.likes -= 1;
                } else {
                  await Get.find<DocumentController>().likeDislikeDocument(
                      documentId: widget.document.documentId, mode: "like");
                  widget.document.likes += 1;
                }
                controller.isLiked.value = !controller.isLiked.value;
                widget.document.isLiked = controller.isLiked.value;
                controller.isLoading.value = false;
              },
              child: controller.isLoading.value
                  ? const SizedBox(width: 25, child: Loader2(size: 15))
                  : controller.isLiked.value
                      ? const CustomIcon(
                          path: "assets/icons/heart-solid.svg",
                          size: 25,
                          color: Colors.red,
                        )
                      : const CustomIcon(
                          path: "assets/icons/heart.svg",
                          size: 25,
                        ),
            ),
            const SizedBox(width: 4),
            Text("${widget.document.likes}", style: AppTypography.body1),
            const SizedBox(width: 12),
            const CustomIcon(path: "assets/icons/send.svg"),
            const Spacer(),
            GetX<BookmarkController>(builder: (controller) {
              return GestureDetector(
                onTap: () async {
                  controller.isLoading.value = true;
                  if (controller.isBookmarked.value) {
                    await Get.find<DocumentController>()
                        .bookmarkUnBookmarkDocument(
                      documentId: widget.document.documentId,
                      mode: "unMark",
                    );
                  } else {
                    await Get.find<DocumentController>()
                        .bookmarkUnBookmarkDocument(
                      documentId: widget.document.documentId,
                      mode: "bookmark",
                    );
                  }
                  widget.document.isBookmarked = !widget.document.isBookmarked;
                  controller.isBookmarked.value =
                      !controller.isBookmarked.value;
                  controller.isLoading.value = false;
                },
                child: controller.isLoading.value
                    ? const SizedBox(width: 25, child: Loader2(size: 15))
                    : controller.isBookmarked.value
                        ? const CustomIcon(
                            path: "assets/icons/bookmark-mark.svg",
                          )
                        : const CustomIcon(path: "assets/icons/bookmark.svg"),
              );
            }),
          ],
        );
      }),
    );
  }
}
