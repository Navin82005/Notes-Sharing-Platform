import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_hub/controller/document_controller.dart';
import 'package:note_hub/core/helper/hive_boxes.dart';
import 'package:note_hub/model/document_model.dart';
import 'package:note_hub/view/widgets/document_card.dart';

// final List<DocumentModel> document = [
//   DocumentModel(
//     name: "Big Data",
//     topic: "DSA",
//     description: "full course notes for Big Data in DSA",
//     likes: 12,
//     icon:
//         "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
//     dateOfUpload: DateTime(2024, 1, 2),
//   ),
//   DocumentModel(
//     name: "Backtracking Concepts",
//     topic: "DSA",
//     description: "conceptual learning of backtracking using python",
//     likes: 120,
//     icon:
//         "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
//     dateOfUpload: DateTime(2024, 8, 2),
//   ),
// ];
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Get.put(DocumentController());
    loadData();
  }

  loadData() async {
    Get.find<DocumentController>().fetchDocsForUsername(
      username: HiveBoxes.userBox.get("data")!.username,
    );
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SafeArea(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
