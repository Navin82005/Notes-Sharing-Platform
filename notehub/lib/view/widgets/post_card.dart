import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:notehub/controller/document_controller.dart";
import "package:notehub/core/config/color.dart";
import "package:notehub/core/config/typography.dart";
import "package:notehub/core/helper/custom_icon.dart";
import "package:notehub/model/document_model.dart";
import "package:notehub/view/document_screen/document.dart";
import "package:notehub/view/profile_screen/profile_user.dart";
import "package:notehub/view/widgets/loader.dart";

class PostCard extends StatefulWidget {
  final DocumentModel document;
  const PostCard({
    super.key,
    required this.document,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.document.isLiked;
    isBookmarked = widget.document.isBookmarked;
  }

  @override
  Widget build(context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        // color: GrayscaleWhiteColors.darkWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _renderHeader(),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => Get.to(
              () => Document(document: widget.document),
              transition: Transition.rightToLeft,
            ),
            child: _renderImage(),
          ),
          _renderFooter(),
        ],
      ),
    );
  }

  _renderHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.to(
              () => ProfileUser(username: widget.document.username),
              transition: Transition.rightToLeft,
            ),
            child: Row(
              children: [
                CustomAvatar(path: widget.document.profile),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.document.displayName,
                        style: AppTypography.subHead1),
                    Text(widget.document.username, style: AppTypography.body4),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          const CustomIcon(path: "assets/icons/ellipsis-vertical.svg"),
        ],
      ),
    );
  }

  _renderImage() {
    print("document.icon: ${widget.document.icon}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CachedNetworkImage(
        height: 350,
        width: Get.width,
        fit: BoxFit.cover,
        imageUrl: widget.document.icon,
        placeholder: (context, url) => const Loader(),
        errorWidget: (context, url, error) {
          return Container(
            color: GrayscaleWhiteColors.almostWhite,
            child: Center(
              child: Text(
                "Unable to load Thumbnail",
                style: AppTypography.body2,
              ),
            ),
          );
        },
      ),
    );
  }

  _renderFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 8, right: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.document.isLiked) {
                  widget.document.likes -= 1;
                  Get.find<DocumentController>().likeDislikeDocument(
                      documentId: widget.document.documentId, mode: "dislike");
                } else {
                  widget.document.likes += 1;
                  Get.find<DocumentController>().likeDislikeDocument(
                      documentId: widget.document.documentId, mode: "like");
                }
                widget.document.isLiked = !widget.document.isLiked;
              });
            },
            child: widget.document.isLiked
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
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.document.isBookmarked) {
                  Get.find<DocumentController>().bookmarkUnBookmarkDocument(
                    documentId: widget.document.documentId,
                    mode: "unMark",
                  );
                } else {
                  Get.find<DocumentController>().bookmarkUnBookmarkDocument(
                    documentId: widget.document.documentId,
                    mode: "bookmark",
                  );
                }
                widget.document.isBookmarked = !widget.document.isBookmarked;
              });
            },
            child: widget.document.isBookmarked
                ? const CustomIcon(path: "assets/icons/bookmark-mark.svg")
                : const CustomIcon(path: "assets/icons/bookmark.svg"),
          ),
        ],
      ),
    );
  }
}
