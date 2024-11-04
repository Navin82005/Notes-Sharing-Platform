import 'package:notehub/model/document_model.dart';

class Comment {
  final String comment;
  final int likes;

  Comment({required this.comment, required this.likes});
}

class PostModel {
  final String username;
  final String postName;
  final String postDescription;
  final int postLikes;
  final int postComments;
  final List<Comment> comments;
  final List<DocumentModel> documents;

  PostModel({
    required this.username,
    required this.postName,
    required this.postDescription,
    required this.postLikes,
    required this.postComments,
    required this.comments,
    required this.documents,
  });
}
