import "dart:io";

import "package:dio/dio.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:get/get.dart";
import "package:notehub/controller/download_controller.dart";
import "package:notehub/view/widgets/toasts.dart";
import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";

final dio = Dio();

class FileDownload {
  static void download({
    required String url,
    required String name,
    FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin,
  }) async {
    var downloadDir = await getDownloadsDirectory();
    var downloadUri = Uri.parse(url);

    String savePath = "${downloadDir!.path}_$name";
    if (await ifFileExists(savePath)) {
      Toasts.showTostWarning(message: "Already downloaded: $name");
    }

    var saveFile = File(savePath);

    await dio.downloadUri(
      downloadUri,
      saveFile.path,
      onReceiveProgress: (received, total) {
        Get.find<DownloadController>().downloadProgress.value =
            received / total;
        if (total != -1) {
          int progress = ((received / total) * 100).toInt();
          if (flutterLocalNotificationsPlugin != null) {
            _showProgressNotification(
                progress, flutterLocalNotificationsPlugin);
          }
        }
      },
    );
    if (flutterLocalNotificationsPlugin != null) {
      _showCompleteNotification(flutterLocalNotificationsPlugin, savePath);
    }
    Toasts.showTostSuccess(message: "Downloaded: $name");
  }

  static Future<void> _showProgressNotification(int progress,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Download Progress',
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: 100,
      progress: progress,
    );
    final notificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Downloading',
      '$progress%',
      notificationDetails,
    );
  }

  static Future<void> _showCompleteNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String savePath,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Download Complete',
      importance: Importance.high,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'The file has been downloaded successfully',
      notificationDetails,
      payload: savePath,
    );
  }

  static void onNotificationClick(String? filePath) {
    if (filePath != null) {
      OpenFile.open(filePath);
    }
  }

  static Future<bool> ifFileExists(path) async {
    var file = File(path);
    if (await file.exists()) {
      return true;
    }

    return false;
  }
}
