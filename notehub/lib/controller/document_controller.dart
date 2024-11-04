import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/core/meta/app_meta.dart';

import 'package:notehub/model/document_model.dart';
import 'package:notehub/service/file_caching.dart';
import 'package:notehub/view/widgets/toasts.dart';
import 'package:open_file/open_file.dart';

class DocumentController extends GetxController {
  var documents = <DocumentModel>[].obs;
  var isLoading = false.obs;

  fetchDocsForUsername({required String username}) async {
    isLoading.value = true;
    documents.clear();

    isLoading.value = false;
  }

  openDocument(url, documentName) async {
    isLoading.value = true;
    var savePath = await saveAndOpenFile(uri: url, name: documentName);
    isLoading.value = false;
    OpenFile.open(savePath);
  }

  fetchDocument({required String documentId}) async {}

  likeDislikeDocument(
      {required String documentId, required String mode}) async {
    try {
      var uri = Uri.parse("${AppMetaData.backend_url}/api/document/like");

      http.Response response;
      if (mode == "like") {
        response = await http.post(
          uri,
          body: {
            "username": HiveBoxes.username,
            "document_id": documentId,
          },
        );
      } else {
        response = await http.delete(
          uri,
          body: {
            "username": HiveBoxes.username,
            "document_id": documentId,
          },
        );
      }

      var body = json.decode(response.body);
      if (body["error"]) {
        Toasts.showTostError(message: body["message"]);
        isLoading.value = false;
        return;
      }
    } catch (e) {
      print("Error in liking document ${e.toString()}");
    }
  }

  bookmarkUnBookmarkDocument(
      {required String documentId, required String mode}) async {
    try {
      var uri = Uri.parse("${AppMetaData.backend_url}/api/document/bookmark");

      http.Response response;
      if (mode == "bookmark") {
        response = await http.post(
          uri,
          body: {
            "username": HiveBoxes.username,
            "document_id": documentId,
          },
        );
      } else {
        response = await http.delete(
          uri,
          body: {
            "username": HiveBoxes.username,
            "document_id": documentId,
          },
        );
      }

      var body = json.decode(response.body);
      if (body["error"]) {
        Toasts.showTostError(message: body["message"]);
        isLoading.value = false;
        return;
      }
    } catch (e) {
      print("Error in liking document ${e.toString()}");
    }
  }
}
