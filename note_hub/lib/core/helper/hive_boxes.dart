import 'package:hive/hive.dart';
import 'package:note_hub/model/user_model.dart';

class HiveBoxes {
  static Box<UserModel> userBox = Hive.box<UserModel>("user");
}
