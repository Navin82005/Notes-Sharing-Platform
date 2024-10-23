import 'package:get/get.dart';
import 'package:note_hub/model/document_model.dart';
import 'package:note_hub/model/post_model.dart';

class ShowcaseController extends GetxController {
  var profilePosts = <PostModel>[].obs;
  var savedPosts = <PostModel>[].obs;

  var isLoading = false.obs;

  fetchProfilePosts({username}) async {
    isLoading.value = true;

    // TODO Fetct data form the server using username

    profilePosts.clear();
    profilePosts.addAll(<PostModel>[
      PostModel(
        username: "navin82005@gmail.com",
        postName: "DSA Notes",
        postDescription: "Full and separate documents of all topics in DSA",
        postLikes: 510,
        postComments: 2,
        comments: [
          Comment(comment: "Thank you for sharing!", likes: 12),
          Comment(comment: "I am very thankful!", likes: 12),
        ],
        documents: [
          DocumentModel(
            name: "Big Data",
            topic: "DSA",
            description: "full course notes for Big Data in DSA",
            likes: 12,
            icon:
                "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
            dateOfUpload: DateTime(2024, 1, 12),
          ),
          DocumentModel(
            name: "Backtracking Concepts",
            topic: "DSA",
            description: "conceptual learning of backtracking using python",
            likes: 120,
            icon:
                "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
            dateOfUpload: DateTime(2024, 8, 12),
          ),
        ],
      ),
      PostModel(
        username: "navin82005@gmail.com",
        postName: "DSA Notes",
        postDescription: "Full and separate documents of all topics in DSA",
        postLikes: 510,
        postComments: 2,
        comments: [
          Comment(comment: "Thank you for sharing!", likes: 12),
          Comment(comment: "I am very thankful!", likes: 12),
        ],
        documents: [
          DocumentModel(
            name: "Big Data",
            topic: "DSA",
            description: "full course notes for Big Data in DSA",
            likes: 12,
            icon:
                "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
            dateOfUpload: DateTime(2024, 11, 2),
          ),
          DocumentModel(
            name: "Backtracking Concepts",
            topic: "DSA",
            description: "conceptual learning of backtracking using python",
            likes: 120,
            icon:
                "https://i.seadn.io/gae/nnpVBgXNaLZoXZUjJcaDf5a9zRgV66N131bUXdAfnmsROeVdE3jsZCnkDm3lvoXotyFZrpJd36J4wha9cvizl9Mp4VfSpFyE9BPr?auto=format&dpr=1&w=1000",
            dateOfUpload: DateTime(2024, 8, 12),
          ),
        ],
      ),
    ]);

    isLoading.value = false;
  }

  fetchSavedPosts({username}) async {}
}
