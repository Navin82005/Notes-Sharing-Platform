import 'dart:convert';

import 'package:get/get.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/core/meta/app_meta.dart';
import 'package:notehub/model/user_model.dart';

import 'package:http/http.dart' as http;
import 'package:notehub/view/widgets/toasts.dart';

class ProfileUserController extends GetxController {
  var profileData = UserModel(
    displayName: '',
    username: "",
    institute: "",
    profile: "",
    followers: 0,
    following: 0,
    documents: 0,
  ).obs;

  var isLoading = false.obs;

  fetchUserData({username}) async {
    isLoading.value = true;

    var uri = Uri.parse(
        "${AppMetaData.backend_url}/api/user/fetch/${HiveBoxes.username}");

    try {
      var response = await http.post(uri, body: {"username": username});
      var response_data = json.decode(response.body);
      if (response_data["error"] == true) {
        print("Error: ${response_data['message']}");
        if (HiveBoxes.userBox.containsKey("data")) {
          profileData.value = HiveBoxes.userBox.get("data")!;
        }
        isLoading.value = false;
        return;
      }
      var user = response_data["user"];
      print(user);
      profileData.value = profileData.value.copyWith(
        displayName: user["display_name"],
        username: user["username"],
        profile: user["profile"] ?? "NA",
        institute: user["institute"],
        followers: user["followers"],
        following: user["following"],
        documents: user["files"].length,
        isFollowedByUser: user["isFollowedByUser"] ?? false,
      );
    } catch (error) {
      print("Error in fetching user data: ${error.toString()}");
    }
    isLoading.value = false;
  }

  follow({username, isProfile = true}) async {
    isLoading.value = true;
    try {
      var url = Uri.parse(
          "${AppMetaData.backend_url}/api/user/follow/${HiveBoxes.username}");
      print("${AppMetaData.backend_url}/api/user/follow/${HiveBoxes.username}");

      var response = await http.post(url, body: {
        "username": username,
      });
      var body = json.decode(response.body);
      if (body["error"]) {
        Toasts.showTostError(message: "Unable to take action");
        isLoading.value = false;
        return false;
      } else {
        if (profileData.value.isFollowedByUser) {
          Toasts.showTostSuccess(message: "Un followed $username");
        } else {
          Toasts.showTostSuccess(message: "Followed $username");
        }
      }
    } catch (e) {
      Toasts.showTostError(message: "Unable to take action");
      print("Error in following $username");
      isLoading.value = false;
      return false;
    }
    isLoading.value = false;
    if (isProfile) {
      await fetchUserData(username: username);
    }

    return true;
  }

  checkFollowers({username}) async {}
}
