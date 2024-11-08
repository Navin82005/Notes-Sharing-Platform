import 'dart:convert';

import 'package:get/get.dart';
import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/core/meta/app_meta.dart';
import 'package:notehub/model/user_model.dart';

import 'package:http/http.dart' as http;
import 'package:notehub/view/auth_screen/login.dart';
import 'package:notehub/view/widgets/toasts.dart';

class ProfileController extends GetxController {
  var profileData = UserModel(
    displayName: '',
    username: "",
    institute: "",
    profile: "NA",
    followers: 0,
    following: 0,
    documents: 0,
  ).obs;

  var isLoading = false.obs;

  fetchUserData({username}) async {
    isLoading.value = true;

    var uri = Uri.parse("${AppMetaData.backend_url}/api/user/$username");

    // await Future.delayed(const Duration(seconds: 3));

    try {
      var response = await http.get(uri);
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
      var newUser = UserModel(
        displayName: user["display_name"],
        username: user["username"],
        institute: user["institute"],
        profile: user["profile"] ?? "NA",
        documents: user["files"],
        followers: user["followers"],
        following: user["following"],
      );
      await HiveBoxes.setUser(newUser);
      profileData.value = profileData.value.copyWith(
        displayName: user["display_name"],
        username: user["username"],
        profile: user["profile"] ??
            "${AppMetaData.avatar_url}&name=${user["display_name"]}",
        institute: user["institute"],
        followers: user["followers"],
        following: user["following"],
        documents: user["files"],
      );
    } catch (error) {
      print("Error in fetching user data: ${error.toString()}");
    }
    isLoading.value = false;
  }

  logoutUser() async {
    await HiveBoxes.resetUser();
    Get.off(() => const Login());
  }
}
