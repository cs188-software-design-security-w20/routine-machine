// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.userID,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.follower,
    this.following,
    this.pendingFollower,
    this.pendingFollowing,
  });

  String userID;
  String username;
  String firstName;
  String lastName;
  String email;
  List<String> follower;
  List<String> following;
  List<String> pendingFollower;
  List<String> pendingFollowing;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userID: json["userID"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        follower: List<String>.from(json["follower"].map((x) => x)),
        following: List<String>.from(json["following"].map((x) => x)),
        pendingFollower:
            List<String>.from(json["pendingFollower"].map((x) => x)),
        pendingFollowing:
            List<String>.from(json["pendingFollowing"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "follower": List<dynamic>.from(follower.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "pendingFollower": List<dynamic>.from(pendingFollower.map((x) => x)),
        "pendingFollowing": List<dynamic>.from(pendingFollowing.map((x) => x)),
      };
}
