/// Represents a user profile from the Routine Machine API
class UserProfile {
  final String userID;
  final String userName;
  final String bio;
  final String profileImage;

  UserProfile.fromJSON(Map<String, dynamic> json)
      : userID = json['user_id'],
        userName = json['user_name'],
        bio = json['bio'],
        profileImage = json['profile_image'];
}
