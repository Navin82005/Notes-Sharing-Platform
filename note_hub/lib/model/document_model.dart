class DocumentModel {
  String name;
  String description;
  String topic;
  String icon;
  int likes;
  DateTime dateOfUpload;

  DocumentModel({
    required this.name,
    required this.topic,
    required this.description,
    required this.likes,
    required this.icon,
    required this.dateOfUpload,
  });
}
