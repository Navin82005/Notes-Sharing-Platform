import 'package:get/get.dart';
import 'package:note_hub/model/user_model.dart';

class ProfileController extends GetxController {
  var profileData = UserModel(
    displayName: '',
    username: "",
    institute: "",
    profile: "",
    followers: 0,
    following: 0,
    documents: 0,
  ).obs;

  var isLoading = false.obs;

  fetchUserData({username}) async {
    isLoading.value = true;

    // TODO Fetch user data from the server using username

    profileData.value = profileData.value.copyWith(
      displayName: "Naveen N",
      username: "navin82005@gmail.com",
      institute: "Sri Shakthi Institute of Engineering Technology",
      profile:
          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      followers: 10,
      following: 12,
      documents: 0,
    );

    isLoading.value = false;
  }
}
