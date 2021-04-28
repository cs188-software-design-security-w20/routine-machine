import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:http/http.dart' as Http;
import 'dart:convert' as Convert;
import '../Models/UserProfile.dart';

class APIWrapper {
  Auth.FirebaseUser user;
  APIWrapper(this.user);

  Future<UserProfile> getUserProfile({String username}) async {
    return UserProfile.fromJSON({
      'user_id': 'temp',
      'user_name': 'temp',
      'bio': 'temp',
      'profile_image': null,
    });
  }

  Future<String> getUserPublicKey({String userID}) async {
    String publicKey = 'temp';
    return publicKey;
  }

  void updateOwnerPublicKey({String publicKey}) async {}

  Future<String> getEncryptedDEK({String userID, String followerID}) async {
    String encryptedDEK = 'temp';
    return encryptedDEK;
  }

  void updateOwnerDEK({String ownerDEK}) async {}

  void sendFollowRequest({String targetUserID}) async {}

  Future<List<String>> getFollowRequests() async {
    return [];
  }

  Future<List<String>> getFollowers() async {
    return [];
  }

  void approveFollowRequest({String targetUserID, String ownerDEK}) async {}

  void removeFollower({String targetUserID}) async {}

  void unfollowUser({String targetUserID}) async {}

  Future<Map<String, dynamic>> getHabitData() async {
    return {};
  }
}
