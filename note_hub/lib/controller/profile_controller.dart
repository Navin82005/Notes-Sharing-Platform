import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_hub/core/meta/app_meta.dart';
import 'package:note_hub/model/user_model.dart';

import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
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

    var uri = Uri.parse("${AppMetaData.backend_url}/api/user/$username");

    try {
      var response = await http.get(uri);
      print(json.decode(response.body));
    } catch (error) {
      print("Error in fetching user data: ${error.toString()}");
    }

    await Future.delayed(const Duration(seconds: 3));

    profileData.value = profileData.value.copyWith(
      displayName: "Naveen N",
      username: "navin82005@gmail.com",
      institute: "Sri Shakthi Institute of Engineering Technology",
      profile:
          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      followers: 10,
      following: 12,
      documents: 0,
    );

    isLoading.value = false;
  }
}
