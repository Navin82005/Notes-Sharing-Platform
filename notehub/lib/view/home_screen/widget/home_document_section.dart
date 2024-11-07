import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/controller/home_controller.dart';

import 'package:notehub/view/widgets/post_card.dart';
import 'package:notehub/view/widgets/refresher_widget.dart';

class HomeDocumentSection extends StatelessWidget {
  const HomeDocumentSection({super.key});

  _handleRefresh() async {
    var controller = Get.find<HomeController>();

    await controller.fetchUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return RefresherWidget(
      onRefresh: () async {
        await _handleRefresh();
      },
      child: GetX<HomeController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const SizedBox.shrink();
          }

          if (controller.updates.isEmpty) {
            return Container(
              width: Get.width,
              height: Get.height,
              child: const Expanded(
                child: Center(
                  child: Text("Follow Some People"),
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.updates.length,
            itemBuilder: (context, index) {
              return PostCard(
                document: controller.updates[index],
              );
            },
          );
        },
      ),
    );
  }
}
