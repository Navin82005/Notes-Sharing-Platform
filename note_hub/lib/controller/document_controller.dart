import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:note_hub/controller/file_controller.dart';
import 'package:note_hub/core/meta/app_meta.dart';

import 'package:note_hub/model/document_model.dart';

class DocumentController extends GetxController {
  var documents = <DocumentModel>[].obs;
  var isLoading = false.obs;

  fetchDocsForUsername({required String username}) async {
    isLoading.value = true;

    documents.clear();
    print("Fetching data from ${AppMetaData.backend_url}/documents/$username");

    isLoading.value = false;
  }

  fetchDocument({required String documentId}) async {
    Uri uri;
    // try {
    //   uri = Uri.parse();
    // }
  }
}
