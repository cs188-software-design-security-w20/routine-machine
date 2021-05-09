// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.userId,
    this.userName,
    this.email,
    this.follower,
    this.following,
    this.pendingFollower,
    this.pendingFollowing,
  });

  String userId;
  String userName;
  String email;
  List<String> follower;
  List<String> following;
  List<String> pendingFollower;
  List<String> pendingFollowing;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["userID"],
        userName: json["userName"],
        email: json["email"],
        follower: List<String>.from(json["follower"].map((x) => x)),
        following: List<String>.from(json["following"].map((x) => x)),
        pendingFollower:
            List<String>.from(json["pendingFollower"].map((x) => x)),
        pendingFollowing:
            List<String>.from(json["pendingFollowing"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "userName": userName,
        "email": email,
        "follower": List<dynamic>.from(follower.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "pendingFollower": List<dynamic>.from(pendingFollower.map((x) => x)),
        "pendingFollowing": List<dynamic>.from(pendingFollowing.map((x) => x)),
      };
}
