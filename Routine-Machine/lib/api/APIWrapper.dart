import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:http/http.dart' as Http;
import 'dart:convert' as Convert;
import '../Models/UserProfile.dart';

class APIWrapper {
  Auth.User user;
  String apiBaseURL = 'www.example.com';
  Http.BaseClient client = new Http.Client();

  static final APIWrapper _instance = APIWrapper._create();
  factory APIWrapper() => _instance;
  APIWrapper._create();

  injectHttpClient({Http.BaseClient client}) {
    this.client = client;
  }

  void setUser(Auth.User user) {
    this.user = user;
  }

  Future<String> _getAuthHeader() async {
    if (user == null) {
      throw Exception(
          'No associated firebase user. Be sure to use "setUser" before other methods');
    }
    final authToken = await user.getIdToken();
    return 'Bearer $authToken';
  }

  Future<UserProfile> getUserProfile({String username}) async {
    final query = {
      'user_name': username,
    };
    final headers = {
      HttpHeaders.authorizationHeader: _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/user/profile', query);
    final response = await client.get(url, headers: headers);
    final json = Convert.jsonDecode(response.body);
    return UserProfile.fromJSON(json);
  }

  Future<String> getUserPublicKey({String userID}) async {
    final query = {
      'user_id': userID,
    };
    final headers = {
      HttpHeaders.authorizationHeader: _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/user/publickey', query);
    final response = await client.get(url, headers: headers);
    final json = Convert.jsonDecode(response.body);
    return json['public_key'];
  }

  Future<void> updateOwnerPublicKey({String publicKey}) async {}

  Future<String> getEncryptedDEK({String userID, String followerID}) async {
    String encryptedDEK = 'temp';
    return encryptedDEK;
  }

  Future<void> updateOwnerDEK({String ownerDEK}) async {}

  Future<void> sendFollowRequest({String targetUserID}) async {}

  Future<List<String>> getFollowRequests() async {
    return [];
  }

  Future<List<String>> getFollowers() async {
    return [];
  }

  Future<void> approveFollowRequest(
      {String targetUserID, String ownerDEK}) async {}

  Future<void> removeFollower({String targetUserID}) async {}

  Future<void> unfollowUser({String targetUserID}) async {}

  Future<Map<String, dynamic>> getHabitData() async {
    return {};
  }
}
