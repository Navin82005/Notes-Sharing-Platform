import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:notehub/core/helper/hive_boxes.dart';

import 'package:notehub/core/meta/app_meta.dart';
import 'package:notehub/layout.dart';
import 'package:notehub/model/user_model.dart';

import 'package:notehub/view/widgets/toasts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();

  bool verifyForm() {
    if (emailEditingController.text == "" ||
        !emailEditingController.text.contains("@")) {
      Toasts.showTostWarning(message: "Enter a valid email address");
      return false;
    }

    if (passwordEditingController.text == "") {
      Toasts.showTostWarning(message: "Enter a valid password");
      return false;
    }

    return true;
  }

  loginWithEmail() async {
    print(emailEditingController.text);
    print(passwordEditingController.text);
    isLoading.value = true;

    if (verifyForm()) {
      var formData = json.encode({
        "username": emailEditingController.text,
        "password": passwordEditingController.text,
      });
      Uri uri = Uri.parse("${AppMetaData.backend_url}/api/user/login/email");
      try {
        var response = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: formData,
        );

        var body = json.decode(response.body);

        if (body["error"]) {
          Toasts.showTostError(message: "wrong username or password");
        } else {
          var user = body["user"];
          var newUser = UserModel(
            displayName: user["display_name"],
            username: user["username"],
            institute: user["institute"],
            profile: user["profile"] ?? "NA",
            documents: user["files"].length,
            followers: user["followers"]["count"],
            following: user["following"]["count"],
          );
          await HiveBoxes.setUser(newUser);
          Get.off(() => const Layout());
        }
      } catch (error) {
        print("Error: ${error.toString()}");
      }
    }
    isLoading.value = false;
  }

  loginWithGoogle() async {}
}
