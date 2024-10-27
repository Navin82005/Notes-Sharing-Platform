import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:note_hub/core/meta/app_meta.dart';

import 'package:note_hub/model/document_model.dart';

class ShowcaseController extends GetxController {
  var profilePosts = <DocumentModel>[].obs;
  var savedPosts = <DocumentModel>[].obs;

  var isLoading = false.obs;

  fetchProfilePosts({username}) async {
    isLoading.value = true;

    profilePosts.clear();
    update();
    // await Future.delayed(const Duration(seconds: 3));
    Uri uri;
    try {
      uri = Uri.parse("${AppMetaData.backend_url}/api/documents/$username");
      var response = await http.get(uri);
      var body = json.decode(response.body);

      if (body["error"]) {
        isLoading.value = false;
        return;
      }
      var tmpData = <DocumentModel>[];
      var data = body["documents"];
      for (var doc in data) {
        var tmp = DocumentModel(
          name: doc["name"],
          topic: doc["topic"],
          description: doc["description"],
          likes: doc["likes"],
          icon:
              '${AppMetaData.backend_url}/api/documents/download/${doc["cover"]}',
          dateOfUpload: DateTime.parse(doc["dateOfUpload"]),
          documentName: doc["documentName"],
          document:
              '${AppMetaData.backend_url}/api/documents/download/${doc["document"]}',
        );
        tmpData.add(tmp);
      }
      profilePosts.value = tmpData;
      update();
    } catch (e) {
      print("Error in fetching profile posts: ${e.toString()}");
    }

    isLoading.value = false;
  }

  fetchSavedPosts({username}) async {}
}
