class UserModel {
  final String username;
  final String institute;
  final int following;
  final int followers;

  UserModel({
    required this.username,
    required this.institute,
    required this.followers,
    required this.following,
  });
}
