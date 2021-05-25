import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  final String userID;
  final String username;
  final Object profile;
  final String firstName;
  final String lastName;
  final String publicKey;

  UserProfile({
    this.userID,
    this.username,
    this.profile,
    this.firstName,
    this.lastName,
    this.publicKey,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : userID = json['id'],
        username = json['user_name'],
        profile = json['profile'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        publicKey = json['public_key'];

  Map<String, dynamic> toJson() => {
        'id': userID,
        'user_name': username,
        'profile': profile,
        'first_name': firstName,
        'last_name': lastName,
        'public_key': publicKey,
      };
}
