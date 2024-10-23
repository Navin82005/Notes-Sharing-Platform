import 'package:flutter/material.dart';
import 'package:note_hub/model/document_model.dart';
import 'package:note_hub/view/widgets/document_card.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<DocumentModel> document = [
    DocumentModel(
      name: "Big Data",
      topic: "DSA",
      description: "full course notes for Big Data in DSA",
      likes: 12,
      icon:
          "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
      dateOfUpload: DateTime(2024, 1, 2),
    ),
    DocumentModel(
      name: "Backtracking Concepts",
      topic: "DSA",
      description: "conceptual learning of backtracking using python",
      likes: 120,
      icon:
          "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
      dateOfUpload: DateTime(2024, 8, 2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(child: SizedBox.shrink()),
          DocumentCard(
            document: document[0],
            action: () => print("Editing document ${document[0].name}"),
            onTap: () => print("Opening document ${document[0].name}"),
            actionType: ActionType.edit,
          ),
          DocumentCard(
            document: document[1],
            action: () => print("Editing document ${document[1].name}"),
            onTap: () => print("Opening document ${document[1].name}"),
            actionType: ActionType.edit,
          ),
        ],
      ),
    );
  }
}
