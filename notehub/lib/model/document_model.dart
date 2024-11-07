import 'package:notehub/core/meta/app_meta.dart';

class DocumentModel {
  String username;
  String displayName;
  String profile;
  String name;
  bool isFollowedByUser;
  String description;
  String documentId;
  String topic;
  String icon;
  String iconName;
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
    required this.isFollowedByUser,
    required this.name,
    required this.topic,
    required this.description,
    required this.documentId,
    required this.likes,
    required this.icon,
    required this.iconName,
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
      isFollowedByUser: doc["isFollowedByUser"],
      profile: verifyProfile(doc),
      name: doc["name"],
      topic: doc["topic"],
      description: doc["description"],
      likes: doc["likes"],
      icon: '${AppMetaData.backend_url}/api/documents/download/${doc["cover"]}',
      dateOfUpload: DateTime.parse(doc["dateOfUpload"]),
      documentName: doc["documentName"],
      iconName: doc["coverName"],
      document:
          '${AppMetaData.backend_url}/api/documents/download/${doc["document"]}',
      isLiked: doc["likedBy"] ?? false,
      isBookmarked: doc["bookmarkedBy"] ?? false,
    );
  }

  static String verifyProfile(doc) {
    if (doc["profile"] == "NA" || doc["profile"] == null) {
      print("AppMetaData.avatar_url: ${AppMetaData.avatar_url}");
      return "${AppMetaData.avatar_url}&name=${doc["displayName"]}";
    }
    return '${AppMetaData.backend_url}/api/documents/download/${doc["profile"]}';
  }
}
