import 'package:notehub/core/meta/app_meta.dart';

class DocumentModel {
  String username;
  String displayName;
  String profile;
  String name;
  String description;
  String documentId;
  String topic;
  String icon;
  int likes;
  DateTime dateOfUpload;
  String documentName;
  String document;
  bool isLiked;
  bool isBookmarked;

  DocumentModel({
    required this.username,
    required this.displayName,
    required this.profile,
    required this.name,
    required this.topic,
    required this.description,
    required this.documentId,
    required this.likes,
    required this.icon,
    required this.dateOfUpload,
    required this.documentName,
    required this.document,
    this.isLiked = false,
    this.isBookmarked = false,
  });

  static toDocument(doc) {
    return DocumentModel(
      documentId: doc["_id"],
      username: doc["username"],
      displayName: doc["displayName"],
      profile: verifyProfile(doc),
      name: doc["name"],
      topic: doc["topic"],
      description: doc["description"],
      likes: doc["likes"],
      icon: '${AppMetaData.backend_url}/api/documents/download/${doc["cover"]}',
      dateOfUpload: DateTime.parse(doc["dateOfUpload"]),
      documentName: doc["documentName"],
      document:
          '${AppMetaData.backend_url}/api/documents/download/${doc["document"]}',
      isLiked: doc["isLiked"] ?? false,
      isBookmarked: doc["isBookmarked"] ?? false,
    );
  }

  static String verifyProfile(doc) {
    if (doc["profile"] == "" || doc["profile"] == null) {
      return "https://ui-avatars.com/api/?name=${doc["displayName"]}";
    }
    return '${AppMetaData.backend_url}/api/documents/download/${doc["profile"]}';
  }
}
