import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:note_hub/core/meta/app_meta.dart';
import 'package:path/path.dart'; // for filename

class FileUploader {
  // Pick multiple files using ImagePicker
  Future<List<File>?> pickFiles() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      print(images.map((image) => File(image.path)).toList());
      return images.map((image) => File(image.path)).toList();
    }
    return null;
  }

  // Upload multiple files to the server
  Future<void> uploadFiles(List<File> files) async {
    var uri = Uri.parse("${AppMetaData.backend_url}/user/upload");
    var request = http.MultipartRequest('POST', uri);

    // Add the files to the request
    for (var file in files) {
      var fileStream = await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: basename(file.path),
      );
      request.files.add(fileStream);
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Files uploaded successfully!');
        print(response.stream);
      } else {
        print('Failed to upload files. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading files: $e');
    }
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final FileUploader fileUploader = FileUploader();
  List<File>? selectedFiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Files'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                var files = await fileUploader.pickFiles();
                setState(() {
                  selectedFiles = files;
                });
              },
              child: Text('Pick Files'),
            ),
            SizedBox(height: 20),
            if (selectedFiles != null && selectedFiles!.isNotEmpty)
              ElevatedButton(
                onPressed: () async {
                  if (selectedFiles != null) {
                    await fileUploader.uploadFiles(selectedFiles!);
                  }
                },
                child: Text('Upload Files'),
              ),
          ],
        ),
      ),
    );
  }
}
