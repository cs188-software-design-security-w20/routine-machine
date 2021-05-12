/// Represents a user profile from the Routine Machine API
class UserProfile {
  final String userID;
  final String userName;
  final dynamic profile;
  final String firstName;
  final String lastName;

  UserProfile.fromJSON(Map<String, dynamic> json)
      : userID = json['id'],
        userName = json['user_name'],
        profile = json['profile'],
        firstName = json['first_name'],
        lastName = json['last_name'];
}
