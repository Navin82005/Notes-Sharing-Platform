import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:notehub/core/helper/hive_boxes.dart';
import 'package:notehub/core/meta/app_meta.dart';

import 'package:notehub/view/widgets/toasts.dart';

class UploadController extends GetxController {
  var isLoading = false.obs;
  var selectedDocument = Rxn<PlatformFile>();
  var selectedCover = Rxn<PlatformFile>();

  var nameEditingController = TextEditingController();
  var topicEditingController = TextEditingController();
  var descriptionEditingController = TextEditingController();

  pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "doc", "docx", "jpg", "jpeg", "png"],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      selectedDocument.value = result.files.first;
    } else {
      Toasts.showTostWarning(message: "Please select a file");
    }
  }

  pickCover() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      selectedCover.value = result.files.first;
    } else {
      Toasts.showTostWarning(message: "Please select a file");
    }
  }

  checkValidity() {
    if (selectedDocument.value == null) {
      Toasts.showTostWarning(message: "Please select a file");
      return false;
    }
    if (nameEditingController.text == "") {
      Toasts.showTostWarning(message: "Please enter a valid name");
      return false;
    }
    if (topicEditingController.text == "") {
      Toasts.showTostWarning(message: "Please enter a valid topic");
      return false;
    }
    return true;
  }

  uploadDocument() async {
    isLoading.value = true;
    if (!checkValidity()) {
      isLoading.value = false;
      return;
    }
    Uri uri = Uri.parse(
        "${AppMetaData.backend_url}/api/documents/${HiveBoxes.username}");
    var request = http.MultipartRequest("POST", uri);

    var multipartDocumentFile = await http.MultipartFile.fromPath(
      "document",
      selectedDocument.value!.path!,
    );

    request.files.add(multipartDocumentFile);
    if (selectedCover.value != null) {
      var multipartCoverFile = await http.MultipartFile.fromPath(
        "document",
        selectedCover.value!.path!,
      );
      request.files.add(multipartCoverFile);
    }

    request.fields["username"] = HiveBoxes.username;
    request.fields["documentName"] = nameEditingController.text;
    request.fields["topic"] = topicEditingController.text;
    request.fields["description"] = descriptionEditingController.text;
    request.fields["username"] = HiveBoxes.username;

    var response = await request.send();
    var responseBody = json.decode(await response.stream.bytesToString());

    if (responseBody["error"]) {
      Toasts.showTostError(message: "Please fill all the required fields");
    } else {
      clearForm();
    }

    isLoading.value = false;
  }

  clearForm() {
    nameEditingController.clear();
    topicEditingController.clear();
    descriptionEditingController.clear();
    selectedDocument.value = null;
    selectedCover.value = null;
  }
}
