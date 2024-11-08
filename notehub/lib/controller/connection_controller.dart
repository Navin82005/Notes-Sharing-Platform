import 'dart:convert';

import 'package:get/get.dart';

import "package:http/http.dart" as http;

import 'package:notehub/core/helper/hive_boxes.dart';
import 'package:notehub/core/meta/app_meta.dart';
import 'package:notehub/model/mini_user_model.dart';

import 'package:notehub/view/connection_screen/connection.dart';
import 'package:notehub/view/widgets/toasts.dart';

class ConnectionController extends GetxController {
  var isLoading = false.obs;
  var usersData = <MiniUserModel>[].obs;

  void fetchConnection({required ConnectionType type}) async {
    isLoading.value = true;
    // await Future.delayed(const Duration(seconds: 3));
    try {
      var url = Uri.parse(
          "${AppMetaData.backend_url}/api/user/fetch/${HiveBoxes.username}/${type.name}");
      var response = await http.post(url);

      var data = json.decode(response.body);
      if (data["error"]) {
        Toasts.showTostError(message: "Error fetching ${type.name}");
        print("Error in fetching user ${type.name}: ${data["message"]}");
      } else {
        usersData.clear();
        for (var user in data["users"]) {
          usersData.add(MiniUserModel.toMiniUserModel(user));
        }
      }
    } catch (e) {
      Toasts.showTostError(message: "Error fetching ${type.name}");
      Toasts.showTostError(message: e.toString());
      print("Error in fetching user ${type.name}: ${e.toString()}");
    }

    isLoading.value = false;
  }
}
