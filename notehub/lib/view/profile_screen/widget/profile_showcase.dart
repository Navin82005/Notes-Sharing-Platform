import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notehub/view/profile_screen/widget/post_renderer.dart';
import 'package:notehub/controller/showcase_controller.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

class ProfileTabController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

class ProfileShowcase extends StatefulWidget {
  final String? username;
  const ProfileShowcase({super.key, this.username});

  @override
  State<ProfileShowcase> createState() => _ProfileShowcaseState();
}

class _ProfileShowcaseState extends State<ProfileShowcase>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ProfileTabController profileTabController =
      Get.put(ProfileTabController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: HiveBoxes.username == widget.username ? 2 : 1,
      vsync: this,
    );

    // Listen to tab changes (scrolling or tapping) and update the selectedIndex
    _tabController.addListener(() {
      profileTabController.changeTabIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Obx(
            () => TabBar(
              controller: _tabController,
              indicatorColor: GrayscaleBlackColors.tintedBlack,
              labelColor: GrayscaleBlackColors.black,
              unselectedLabelColor: GrayscaleGrayColors.silver,
              tabs: [
                Tab(
                  icon: CustomIcon(
                    path: profileTabController.selectedIndex.value == 0
                        ? "assets/icons/book.svg"
                        : "assets/icons/book.svg",
                  ),
                ),
                if (HiveBoxes.username == widget.username)
                  Tab(
                    icon: CustomIcon(
                      path: profileTabController.selectedIndex.value == 1
                          ? "assets/icons/bookmark-mark.svg"
                          : "assets/icons/bookmark.svg",
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PostsRenderer(
                  usernameTag: widget.username!,
                  posts: Get.find<ShowcaseController>(tag: widget.username)
                      .profilePosts,
                ),
                if (HiveBoxes.username == widget.username)
                  PostsRenderer(
                    usernameTag: widget.username!,
                    posts: Get.find<ShowcaseController>(tag: widget.username)
                        .savedPosts,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
