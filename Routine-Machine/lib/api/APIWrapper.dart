import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:http/http.dart' as Http;
import 'package:routine_machine/api/CSE.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'dart:convert' as Convert;

class APIWrapper {
  Auth.User user;
  String apiBaseURL = 'localhost:8000';
  Http.BaseClient client = new Http.Client();
  CSE cse = CSE();

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
    return 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjUzNmRhZWFiZjhkZDY1ZDRkZTIxZTgyNGI4OTlhMWYzZGEyZjg5NTgiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcm91dGluZS1tYWNoaW5lLTU2ZWMxIiwiYXVkIjoicm91dGluZS1tYWNoaW5lLTU2ZWMxIiwiYXV0aF90aW1lIjoxNjIwOTMwMjA1LCJ1c2VyX2lkIjoic3hEQ000RGdsUmdJSHB1dExrTlpWM0ZIRXlBMyIsInN1YiI6InN4RENNNERnbFJnSUhwdXRMa05aVjNGSEV5QTMiLCJpYXQiOjE2MjA5MzAyMDUsImV4cCI6MTYyMDkzMzgwNSwiZW1haWwiOiJyaWNoYXJkLmN4LnRhbmdAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInJpY2hhcmQuY3gudGFuZ0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.N6eBnP3E_jVKISyvpd88l_rB6nuYxaPWUbjLfam_y6X4b5lLycX0xklS8CvJw_TWIYkntNHEClBHyXw-lpbvapEEGUP9FBRWNkRBWxjqKaETjCdDhZjihtp9_ECWdmdDqnrzz4CMqoH5UV6FeZzDaoqwvV6ZiNr1aEVj0WN1ZPmv-jMw7RR0vZrwtMf0GPZax1_OhIP4P2oENOaW3nuQTEqb1yMF9-xBerUM_8BufD5rYB9IqS9LGQi3Q-oSc7fnlFHcdojP5DRpKAxytX_Ms2Ec6x0mC4DRK-CVal7rVtts9RJ61jopdF-MpHpEfzX5CtJYRTFTYbXa04ylNa35dg';
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
    return UserProfile.fromJson(json);
  }

  Future<void> setUserProfile({Map<String, dynamic> userProfile}) async {
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

  Future<void> _setOwnDEK() async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.http(apiBaseURL, '/user/dek');
    final encryptedDEK = await cse.encryptOwnerDEK();
    final response = await client.post(url, headers: headers, body: {
      'id': 'vgtA9uzhBuURByr7aXeUEtbs1yC3', //user.uid,'
      'dek': encryptedDEK.toString(),
    });
  }

  Future<List<WidgetData>> getHabitData() async {
    return [];
  }

  Future<List<WidgetData>> getFollowingHabitData({String id}) async {
    return [];
  }

  Future<void> setHabitData() async {}

  Future<void> sendFollowRequest({String targetUserID}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.http(apiBaseURL, '/follow/requests');
    final response = await client.post(url, headers: headers, body: {
      'followee_id': targetUserID,
      'follower_id': 'WAYuxGZyXseKqBbFluqmCgyDH4O2', //user.uid,
    });
    if (response.statusCode != 200) {
      final errorResponse = Convert.jsonDecode(response.body);
      if (errorResponse['name'] == 'SequelizeUniqueConstraintError')
        throw Exception(
            'Failed to send follow request to user with user id ($targetUserID): Following relation already exists');
      if (errorResponse['name'] == 'SequelizeForeignKeyConstraintError')
        throw Exception(
            'Failed to send follow request to user with user id ($targetUserID): User or target id was incorrect');
      else
        throw Exception(
            'Failed to send follow request to user with user id ($targetUserID)');
    }
  }

  Future<List<UserProfile>> getPendingFollowerRequests() async {
    final query = {
      'followee_id': 'vgtA9uzhBuURByr7aXeUEtbs1yC3', //user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.http(apiBaseURL, '/follow/followers/requests', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get pending follower requests');
    }
    if (response.body == '') {
      throw Exception(
          'Request for pending follower requests was empty. Perhaps the id was incorrect?');
    }
    final resJson = Convert.jsonDecode(response.body) as List;
    if (!(resJson is List)) {
      throw Exception(
          'Request for pending follower requests returned malformed response');
    }
    final profileList =
        resJson.map((profile) => UserProfile.fromJson(profile)).toList();
    return profileList;
  }

  Future<List<UserProfile>> getPendingFollowingRequests() async {
    final query = {
      'follower_id': 'WAYuxGZyXseKqBbFluqmCgyDH4O2', //user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.http(apiBaseURL, '/follow/following/requests', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get pending following requests');
    }
    if (response.body == '') {
      throw Exception(
          'Request for pending following requests was empty. Perhaps the id was incorrect?');
    }
    final resJson = Convert.jsonDecode(response.body) as List;
    if (!(resJson is List)) {
      throw Exception(
          'Request for pending following requests returned malformed response');
    }
    final profileList =
        resJson.map((profile) => UserProfile.fromJson(profile)).toList();
    return profileList;
  }

  Future<List<UserProfile>> getFollowers() async {
    final query = {
      'followee_id': 'vgtA9uzhBuURByr7aXeUEtbs1yC3',
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.http(apiBaseURL, '/follow/followers', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get followers');
    }
    if (response.body == '') {
      throw Exception(
          'Request for followers returned empty response: Perhaps the user id was incorrect?');
    }
    final resJson = Convert.jsonDecode(response.body) as List;
    if (!(resJson is List)) {
      throw Exception(
          'Request for pending follower requests returned malformed response');
    }
    final profileList =
        resJson.map((profile) => UserProfile.fromJson(profile)).toList();
    return profileList;
  }

  Future<List<UserProfile>> getFollowing() async {
    final query = {
      'follower_id': 'WAYuxGZyXseKqBbFluqmCgyDH4O2',
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.http(apiBaseURL, '/follow/following', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get followed users');
    }
    if (response.body == '') {
      throw Exception(
          'Request for followed users returned empty response: Perhaps the user id was incorrect?');
    }
    final resJson = Convert.jsonDecode(response.body) as List;
    if (!(resJson is List)) {
      throw Exception(
          'Request for pending follower requests returned malformed response');
    }
    final profileList =
        resJson.map((profile) => UserProfile.fromJson(profile)).toList();
    return profileList;
  }

  Future<void> approveFollowRequest(
      {String targetUserID, String targetUserPublicKey}) async {
    final encryptedDEK = await (() async {
      if (await cse.hasDEK())
        return cse.encryptOwnerDEK(usingPublicKey: targetUserPublicKey);
      else
        return EncryptedDEK(encrypted: '', iv: '');
    })();
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.http(apiBaseURL, '/follow/requests');
    final response = await client.post(url, headers: headers, body: {
      'followee_id': 'vgtA9uzhBuURByr7aXeUEtbs1yC3', //user.uid,
      'follower_id': targetUserID,
    });
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to reject follow request from user ($targetUserID)');
    }
  }

  Future<void> rejectFollowRequest({String targetUserID}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.http(apiBaseURL, '/follow/requests');
    final response = await client.delete(url, headers: headers, body: {
      'followee_id': 'vgtA9uzhBuURByr7aXeUEtbs1yC3', //user.uid,
      'follower_id': targetUserID,
    });
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to reject follow request from user ($targetUserID)');
    }
  }

  Future<void> removeFollower({String targetUserID}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.http(apiBaseURL, '/follow');
    final response = await client.delete(url, headers: headers, body: {
      'followee_id': 'vgtA9uzhBuURByr7aXeUEtbs1yC3', //user.uid,
      'follower_id': targetUserID,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to remove follower ($targetUserID)');
    }
  }

  Future<void> removeFollowing({String targetUserID}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.http(apiBaseURL, '/follow');
    final response = await client.delete(url, headers: headers, body: {
      'followee_id': targetUserID,
      'follower_id': 'WAYuxGZyXseKqBbFluqmCgyDH4O2', //user.uid,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to remove follower ($targetUserID)');
    }
  }

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
