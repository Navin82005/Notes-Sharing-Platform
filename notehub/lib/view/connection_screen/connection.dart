import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notehub/core/config/color.dart';

import 'package:notehub/controller/connection_controller.dart';
import 'package:notehub/view/connection_screen/widget/connection_avatar.dart';
import 'package:notehub/view/widgets/refresher_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type.name.capitalize!),
        backgroundColor: GrayscaleWhiteColors.white,
        elevation: 5,
        surfaceTintColor: GrayscaleWhiteColors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: GrayscaleWhiteColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Expanded(child: _renderConnectionList()),
          ],
        ),
      ),
    );
  }

  _renderConnectionList() {
    return GetX<ConnectionController>(builder: (controller) {
      if (controller.isLoading.value) {
        return Shimmer.fromColors(
          baseColor: GrayscaleWhiteColors.almostWhite,
          highlightColor: GrayscaleWhiteColors.white,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 12,
            itemBuilder: (context, index) {
              return const ConnectionAvatar();
            },
          ),
        );
      }
      if (controller.usersData.isEmpty) {
        return _renderEmpty();
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.usersData.length,
        itemBuilder: (context, index) {
          return ConnectionAvatar(user: controller.usersData[index]);
        },
      );
    });
  }

  _renderEmpty() {
    return RefresherWidget(
      onRefresh: () async {
        connectionController.fetchConnection(type: widget.type);
      },
      child: Center(
        child: Text("0 ${widget.type.name.capitalize}"),
      ),
    );
  }
}
