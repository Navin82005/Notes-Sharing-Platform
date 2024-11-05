import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:notehub/controller/document_controller.dart';
import 'package:notehub/controller/home_controller.dart';
import 'package:notehub/core/config/color.dart';

import 'package:notehub/view/widgets/loader.dart';
import 'package:notehub/view/widgets/post_card.dart';

class HomeDocumentSection extends StatelessWidget {
  const HomeDocumentSection({super.key});

  _handleRefresh() async {
    var controller = Get.find<HomeController>();

    await controller.fetchUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: () async {
        await _handleRefresh();
      },
      backgroundColor: OtherColors.amethystPurple,
      showChildOpacityTransition: false,
      color: GrayscaleWhiteColors.white,
      borderWidth: 2,
      animSpeedFactor: 10,
      height: 70,
      child: GetX<HomeController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const SizedBox.shrink();
          }

          if (controller.updates.isEmpty) {
            return Container(
              child: const Expanded(
                child: Center(
                  child: Text("See suggestions"),
                ),
              ),
            );
          }

          return GetX<DocumentController>(builder: (docController) {
            return Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.updates.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      document: controller.updates[index],
                    );
                  },
                ),
                if (docController.isLoading.value)
                  Positioned.fill(
                    child: Container(
                      color: GrayscaleWhiteColors.darkWhite.withOpacity(.5),
                      child: const Center(
                        child: Loader(),
                      ),
                    ),
                  ),
              ],
            );
          });
        },
      ),
    );
  }
}
