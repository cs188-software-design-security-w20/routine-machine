import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:http/http.dart' as Http;
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'dart:convert' as Convert;

class APIWrapper {
  Auth.User user;
  String apiBaseURL = 'localhost:8000';
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
    return 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjUzNmRhZWFiZjhkZDY1ZDRkZTIxZTgyNGI4OTlhMWYzZGEyZjg5NTgiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcm91dGluZS1tYWNoaW5lLTU2ZWMxIiwiYXVkIjoicm91dGluZS1tYWNoaW5lLTU2ZWMxIiwiYXV0aF90aW1lIjoxNjIwNzg5NzA4LCJ1c2VyX2lkIjoic3hEQ000RGdsUmdJSHB1dExrTlpWM0ZIRXlBMyIsInN1YiI6InN4RENNNERnbFJnSUhwdXRMa05aVjNGSEV5QTMiLCJpYXQiOjE2MjA3ODk3MDgsImV4cCI6MTYyMDc5MzMwOCwiZW1haWwiOiJyaWNoYXJkLmN4LnRhbmdAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInJpY2hhcmQuY3gudGFuZ0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.dviDDqXPKn7myaKd9GlYtH2M-VPeaNV7U0Clokqgy8yCjr10wWa3o-MOoyBdAu7F7b8HrOUmFjGpX8VByG6hT4UlmAyfao5NFpmD_QbyxwbvNWAszbGSW91n3h37838Ylm0AW8aVHM7lpY5BLusad4pgp92Kqrem7tAKFX8B8_mSf1bbvv2B8b1jn-V-n6rUZaXASLGbyQEeZo2jhe6VyJAjNm4Tz__j4hx2LG3WmsUtP7jjfc3-FzEL6hXGyrHHkwAg0-RK9ka20sd92TMdjHHh12oXvJJIVVp7zP5ll-doGIvt6Io93D1gAe3jMq4FeHOvbf_3i3QAX_0XFRQAEg';
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
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.http(apiBaseURL, '/user/profile', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      final errorMsg = Convert.jsonDecode(response.body)['message'];
      final formattedError = errorMsg != null ? '($errorMsg)' : '';
      throw Exception('Failed to get user profile $formattedError');
    }
    final json = Convert.jsonDecode(response.body);
    print(json);
    return UserProfile.fromJSON(json);
  }

  Future<void> setUserProfile({Object userProfile}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.http(apiBaseURL, '/user/profile');
    final response = await client.post(url, headers: headers, body: {
      'id': 'vgtA9uzhBuURByr7aXeUEtbs1yC3', //user.uid,
      'profile': Convert.jsonEncode(userProfile),
    });
    if (response.statusCode != 200) {
      final errorMsg = Convert.jsonDecode(response.body)['message'];
      final formattedError = errorMsg != null ? '($errorMsg)' : '';
      throw Exception('Failed to set user profile $formattedError');
    }
  }

  Future<List<WidgetData>> getHabitData() async {
    return [];
  }

  Future<List<WidgetData>> getFollowingHabitData({String id}) async {
    return [];
  }

  Future<void> setHabitData() async {}

  Future<void> sendFollowRequest({String targetUserID}) async {}

  Future<List<UserProfile>> getPendingFollowerRequests() async {
    return [];
  }

  Future<List<UserProfile>> getPendingFollowingRequests() async {
    return [];
  }

  Future<List<UserProfile>> getFollowers() async {
    return [];
  }

  Future<List<UserProfile>> getFollowing() async {
    return [];
  }

  Future<void> approveFollowRequest(
      {String targetUserID, String ownerDEK}) async {}

  Future<void> rejectFollowRequest() async {}

  Future<void> removeFollower({String targetUserID}) async {}

  Future<void> removeFollowing({String targetUserID}) async {}

  // Future<String> getUserPublicKey({String userID}) async {
  //   final query = {
  //     'user_id': userID,
  //   };
  //   final headers = {
  //     HttpHeaders.authorizationHeader: _getAuthHeader(),
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   };
  //   final url = Uri.https(apiBaseURL, '/user/publickey', query);
  //   final response = await client.get(url, headers: headers);
  //   final json = Convert.jsonDecode(response.body);
  //   return json['public_key'];
  // }

  // Future<void> updateOwnerPublicKey({String publicKey}) async {}

  // Future<String> getEncryptedDEK({String userID, String followerID}) async {
  //   String encryptedDEK = 'temp';
  //   return encryptedDEK;
  // }

  // Future<void> updateOwnerDEK({String ownerDEK}) async {}

  // Future<void> sendFollowRequest({String targetUserID}) async {}

  // Future<List<String>> getFollowRequests() async {
  //   return [];
  // }

  // Future<List<String>> getFollowers() async {
  //   return [];
  // }

  // Future<void> approveFollowRequest(
  //     {String targetUserID, String ownerDEK}) async {}

  // Future<void> removeFollower({String targetUserID}) async {}

  // Future<void> unfollowUser({String targetUserID}) async {}
}
