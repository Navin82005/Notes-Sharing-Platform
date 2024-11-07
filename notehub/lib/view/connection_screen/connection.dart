import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/core/config/color.dart';

import 'package:notehub/controller/connection_controller.dart';
import 'package:notehub/view/connection_screen/widget/connection_avatar.dart';
import 'package:shimmer/shimmer.dart';

enum ConnectionType { follower, following }

class Connection extends StatefulWidget {
  final String username;
  final ConnectionType type;
  const Connection({super.key, required this.username, required this.type});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  late ConnectionController connectionController;

  @override
  void initState() {
    super.initState();
    connectionController = Get.put(ConnectionController());
    connectionController.fetchConnection(type: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: .4,
      minChildSize: .2,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: GrayscaleWhiteColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: Get.width / 3,
                ),
                height: 5,
                // width: Get.width / 5,
                decoration: BoxDecoration(
                  color: GrayscaleGrayColors.silver,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Expanded(child: _renderConnectionList(scrollController)),
            ],
          ),
        );
      },
    );
  }

  _renderConnectionList(scrollController) {
    return GetX<ConnectionController>(builder: (controller) {
      if (controller.isLoading.value) {
        return Shimmer.fromColors(
          baseColor: GrayscaleWhiteColors.almostWhite,
          highlightColor: GrayscaleWhiteColors.white,
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: 12,
            itemBuilder: (context, index) {
              return const ConnectionAvatar();
            },
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        itemCount: 12,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(index.toString()),
          );
        },
      );
    });
  }
}
