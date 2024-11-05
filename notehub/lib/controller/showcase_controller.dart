import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:notehub/core/meta/app_meta.dart';

import 'package:notehub/model/document_model.dart';

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
        var tmp = DocumentModel.toDocument(doc);
        tmpData.add(tmp);
      }
      profilePosts.value = tmpData;
      update();
    } catch (e) {
      print("Error in fetching profile posts: ${e.toString()}");
    }

    isLoading.value = false;
  }

  fetchSavedPosts({username}) async {
    isLoading.value = true;

    savedPosts.clear();
    update();
    // await Future.delayed(const Duration(seconds: 3));
    Uri uri;
    try {
      uri =
          Uri.parse("${AppMetaData.backend_url}/api/documents/$username/saved");
      var response = await http.get(uri);
      var body = json.decode(response.body);

      if (body["error"]) {
        isLoading.value = false;
        return;
      }
      var tmpData = <DocumentModel>[];
      var data = body["documents"];
      for (var doc in data) {
        var tmp = DocumentModel.toDocument(doc);
        tmpData.add(tmp);
      }
      savedPosts.value = tmpData;
      update();
    } catch (e) {
      print("Error in fetching saved posts: ${e.toString()}");
    }

    isLoading.value = false;
  }
}
