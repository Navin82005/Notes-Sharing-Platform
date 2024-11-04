import 'package:hive/hive.dart';

import 'package:notehub/model/user_model.dart';

class HiveBoxes {
  static Box<UserModel> userBox = Hive.box<UserModel>("user");

  static String get username => HiveBoxes.userBox.containsKey('data')
      ? userBox.get("data")!.username
      : "";

  static setUser(UserModel newUser) async {
    await userBox.delete("data");
    await userBox.put("data", newUser);
  }
}
