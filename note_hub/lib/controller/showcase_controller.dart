import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:note_hub/core/helper/hive_boxes.dart';
import 'package:note_hub/core/meta/app_meta.dart';

import 'package:note_hub/model/document_model.dart';
import 'package:note_hub/model/post_model.dart';

class ShowcaseController extends GetxController {
  var profilePosts = <PostModel>[].obs;
  var savedPosts = <PostModel>[].obs;

  var isLoading = false.obs;

  fetchProfilePosts({username}) async {
    isLoading.value = true;

    print("Fetching profile posts from server...");
    try {
      Uri uri = Uri.parse(
          "${AppMetaData.backend_url}/user/documents/${HiveBoxes.userBox.get("data")!.username}");
      var response = await http.get(uri);
      var body = json.decode(response.body);

      print(body);

      if (body["error"] == true) {
        print("Error in fetching profile posts: ${body.message}");
      } else {
        print(body["documents"]);
      }
    } catch (e) {
      print("Error in fetching profile posts: ${e.toString()}");
    }

    profilePosts.clear();

    isLoading.value = false;
  }

  fetchSavedPosts({username}) async {}
}
