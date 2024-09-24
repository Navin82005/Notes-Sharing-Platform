import 'package:note_hub/model/post_model.dart';
import 'package:note_hub/model/user_model.dart';

class PostController {
  static PostModel post = PostModel(
    user: UserModel(
      username: "Naveen",
      institute: "Sri Shakthi",
      followers: 2,
      following: 10,
    ),
    postName: "DSA Notes",
    postDescription: "Full and separate documents of all topics in DSA",
    postLikes: 510,
    postComments: 2,
    comments: [
      Comment(comment: "Thank you for sharing!", likes: 12),
      Comment(comment: "I am very thankful!", likes: 12),
    ],
    documents: [],
  );
}
