import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notehub/core/meta/app_meta.dart';

import 'package:notehub/model/document_model.dart';
import 'package:notehub/view/widgets/toasts.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var isFetched = false.obs;

  var updates = <DocumentModel>[].obs;

  fetchUpdates() async {
    isFetched.value = true;
    isLoading.value = true;
    try {
      print("Fetching From: ");
      print("${AppMetaData.backend_url}/api/document/fetch");

      var uri = Uri.parse("${AppMetaData.backend_url}/api/document/fetch");
      var response = await http.get(uri);

      var body = json.decode(response.body);
      if (body["error"] == true) {
        Toasts.showTostError(message: "Error fetching documents");
      }

      var documents = body["documents"];
      updates.clear();

      var tmp = <DocumentModel>[];
      for (var doc in documents) {
        tmp.add(DocumentModel.toDocument(doc));
      }

      updates.value = tmp;
      update();
      // print(body);
    } catch (e) {
      print("HomeController: Error in fetching updates: ${e.toString()}");
    }

    isLoading.value = false;
  }
}
