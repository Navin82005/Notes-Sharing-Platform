import 'package:hive/hive.dart';
import 'package:note_hub/model/user_model.dart';

class HiveBoxes {
  static Box<UserModel> userBox = Hive.box<UserModel>("user");

  static String get username => userBox.get("data")!.username;

  static setUser(UserModel newUser) async {
    await userBox.delete("data");
    await userBox.put("data", newUser);
  }
}
