// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.username,
    this.alias,
    this.email,
    this.follower,
    this.following,
    this.pendingFollower,
    this.pendingFollowing,
  });

  String username;
  String alias;
  String email;
  List<String> follower;
  List<String> following;
  List<String> pendingFollower;
  List<String> pendingFollowing;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        username: json["username"],
        alias: json["alias"],
        email: json["email"],
        follower: List<String>.from(json["follower"].map((x) => x)),
        following: List<String>.from(json["following"].map((x) => x)),
        pendingFollower:
            List<String>.from(json["pendingFollower"].map((x) => x)),
        pendingFollowing:
            List<String>.from(json["pendingFollowing"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "alias": alias,
        "email": email,
        "follower": List<dynamic>.from(follower.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "pendingFollower": List<dynamic>.from(pendingFollower.map((x) => x)),
        "pendingFollowing": List<dynamic>.from(pendingFollowing.map((x) => x)),
      };
}
