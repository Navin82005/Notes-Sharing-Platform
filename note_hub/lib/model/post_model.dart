import 'package:note_hub/model/document_model.dart';
import 'package:note_hub/model/user_model.dart';

class Comment {
  final String comment;
  final int likes;

  Comment({required this.comment, required this.likes});
}

class PostModel {
  final UserModel user;
  final String postName;
  final String postDescription;
  final int postLikes;
  final int postComments;
  final List<Comment> comments;
  final List<DocumentModel> documents;

  PostModel({
    required this.user,
    required this.postName,
    required this.postDescription,
    required this.postLikes,
    required this.postComments,
    required this.comments,
    required this.documents,
  });
}
