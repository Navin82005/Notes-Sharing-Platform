import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:notehub/controller/document_controller.dart';
import 'package:notehub/core/config/color.dart';
import 'package:notehub/core/config/typography.dart';
import 'package:notehub/core/helper/custom_icon.dart';
import 'package:notehub/core/helper/hive_boxes.dart';
import 'package:notehub/model/document_model.dart';
import 'package:notehub/service/file_download.dart';
import 'package:notehub/view/document_screen/widget/doc_description.dart';
import 'package:notehub/view/document_screen/widget/follow_button.dart';
import 'package:notehub/view/widgets/primary_button.dart';
import 'package:notehub/view/widgets/secondary_button.dart';

class Document extends StatefulWidget {
  final DocumentModel document;
  const Document({super.key, required this.document});

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initSettings = InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("response.payload: ${response.payload}");
        FileDownload.onNotificationClick(response.payload);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          shrinkWrap: true,
          children: [
            _renderHeader(),
            const SizedBox(height: 24),
            DocDescription(document: widget.document),
            const SizedBox(height: 24),
            _renderDownloader(),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox.shrink(),
    );
  }

  _renderHeader() {
    print(widget.document.icon);
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomAvatar(path: widget.document.profile),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.document.displayName, style: AppTypography.subHead1),
            Text(widget.document.username, style: AppTypography.body4),
          ],
        ),
        const Spacer(),
        if (HiveBoxes.username != widget.document.username)
          FollowButton(document: widget.document)
        else
          CustomIcon(
            path: "assets/icons/pen.svg",
            size: AppTypography.subHead1.fontSize! + 2,
          ),
      ],
    );
  }

  _renderDownloader() {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            onTap: () {
              Get.find<DocumentController>().openDocument(
                widget.document.document,
                widget.document.documentName,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "View Document",
                style: AppTypography.subHead3.copyWith(
                  color: GrayscaleWhiteColors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SecondaryButton(
          onTap: () {
            FileDownload.download(
              url: widget.document.document,
              name: widget.document.documentName,
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: CustomIcon(path: "assets/icons/download.svg"),
          ),
        ),
      ],
    );
  }
}
