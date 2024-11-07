class MiniUserModel {
  final String displayName;
  final String username;
  final String institute;
  final String profile;
  final bool isFollowedByUser;

  MiniUserModel({
    required this.username,
    required this.displayName,
    required this.institute,
    required this.profile,
    this.isFollowedByUser = false,
  });

  MiniUserModel copyWith({
    String? username,
    String? displayName,
    String? institute,
    String? profile,
    bool? isFollowedByUser,
  }) {
    return MiniUserModel(
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      institute: institute ?? this.institute,
      profile: profile ?? this.profile,
      isFollowedByUser: isFollowedByUser ?? this.isFollowedByUser,
    );
  }

  static MiniUserModel toMiniUserModel(user) {
    return MiniUserModel(
      displayName: user["display_name"],
      username: user["username"],
      profile: user["profile"] ?? "NA",
      institute: user["institute"],
      isFollowedByUser: user["isFollowedByUser"] ?? false,
    );
  }
}
