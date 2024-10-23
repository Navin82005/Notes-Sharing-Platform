import 'package:get/get.dart';
import 'package:note_hub/model/document_model.dart';

class DocumentController extends GetxController {
  var documents = [].obs;
  var isLoading = false.obs;

  fetchDocsForProfile() {
    isLoading.value = true;

    documents.clear();
    documents.addAll([
      DocumentModel(
        name: "Big Data",
        topic: "DSA",
        description: "full course notes for Big Data in DSA",
        likes: 12,
        icon: "assets/images/home.jpeg",
        dateOfUpload: DateTime(2024, 1, 2),
      ),
      DocumentModel(
        name: "Backtracking Concepts",
        topic: "DSA",
        description: "conceptual learning of backtracking using python",
        likes: 120,
        icon: "assets/images/home.jpeg",
        dateOfUpload: DateTime(2024, 8, 24),
      ),
    ]);

    isLoading.value = false;
  }
}
