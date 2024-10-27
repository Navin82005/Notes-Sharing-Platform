import 'package:uuid/uuid.dart';

const uuid = Uuid();

class DocumentFile {
  String id;
  String username;
  String filename;
  String filePath;

  DocumentFile({
    required this.id,
    required this.username,
    required this.filename,
    required this.filePath,
  });
}

class DocumentModel {
  String name;
  String description;
  String topic;
  String icon;
  int likes;
  DateTime dateOfUpload;
  String documentName;
  String document;

  DocumentModel({
    required this.name,
    required this.topic,
    required this.description,
    required this.likes,
    required this.icon,
    required this.dateOfUpload,
    required this.documentName,
    required this.document,
  });
}
