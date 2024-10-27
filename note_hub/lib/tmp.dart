import 'package:flutter/material.dart';

import 'package:note_hub/controller/file_controller.dart';
import 'package:note_hub/controller/showcase_controller.dart';
import 'package:open_file/open_file.dart';

void loadData() async {
  // final rawData = await ShowcaseController.tmpFetchDocumentData();
  // print("RAW DATA: $rawData}");
  // final path = await saveFile(
  //   filename: rawData["filename"],
  //   data: rawData["document"]["data"]["data"],
  // );

  // print(path);
  // await OpenFile.open(path);
}

class Tmp extends StatelessWidget {
  const Tmp({super.key});

  @override
  Widget build(BuildContext context) {
    loadData();
    return const Scaffold();
  }
}
