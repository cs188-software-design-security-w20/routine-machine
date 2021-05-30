import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:http/http.dart' as Http;
import 'package:routine_machine/api/CSE.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'dart:convert' as Convert;
import 'package:crypton/crypton.dart' as Crypton;

class APIWrapper {
  Auth.User user;
  String apiBaseURL = 'routine-machine-1.herokuapp.com';
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
    this.cse.setUID(user.uid);
  }

  void setAPIBaseURL({String baseURL}) {
    this.apiBaseURL = baseURL;
  }

  Future<String> _getAuthHeader() async {
    if (user == null) {
      throw Exception(
          'No associated firebase user. Be sure to use "setUser" before other methods');
    }
    final authToken = await user.getIdToken();
    return 'Bearer $authToken';
  }

  Future<void> overrideKeyPair({String privateKey, String publicKey}) async {
    if (privateKey != null) {
      await cse.setPrivateKey(key: privateKey);
    }
    if (publicKey != null) {
      await cse.setPublicKey(key: publicKey);
    }
  }

  Future<void> createUser(
      {String firstName, String lastName, String userName}) async {
    await cse.refreshOwnerDEK();
    await cse.refreshOwnerPKPair();
    final publicKey = await cse.getPublicKey();
    final dek = await cse.getDEK();
    final encryptedDEK = dek.encrypt(usingPublicKey: publicKey.toString());
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/user');
    final response = await client.post(url, headers: headers, body: {
      'id': user.uid,
      'user_name': userName,
      'first_name': firstName,
      'last_name': lastName,
      'public_key': publicKey.toString(),
      'dek': encryptedDEK.toString(),
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to create new user');
    }
  }

  Future<bool> isUsernameTaken({String username}) async {
    final query = {
      'user_name': username,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/user/username', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to check username avaliability');
    }
    final json = Convert.jsonDecode(response.body);
    return json;
  }

  Future<void> setUserName({String username}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/user/username');
    final response = await client.post(url, headers: headers, body: {
      'id': user.uid,
      'user_name': username.toLowerCase(),
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to set username');
    }
  }

  Future<void> setFirstName({String firstName}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/user/firstName');
    final response = await client.post(url, headers: headers, body: {
      'id': user.uid,
      'first_name': firstName,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to set first name');
    }
  }

  Future<void> setLastName({String lastName}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/user/lastName');
    final response = await client.post(url, headers: headers, body: {
      'id': user.uid,
      'last_name': lastName,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to set last name');
    }
  }

  Future<UserProfile> getUserProfile({String username}) async {
    final query = {
      'user_name': username,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/user/profile', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      final errorMsg = Convert.jsonDecode(response.body)['message'];
      final formattedError = errorMsg != null ? '($errorMsg)' : '';
      throw Exception('Failed to get user profile $formattedError');
    }
    final json = Convert.jsonDecode(response.body);
    return UserProfile.fromJson(json);
  }

  Future<UserProfile> queryUserProfile(/*{String username}*/) async {
    final query = {
      // 'user_name': username,
      'id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/user/profile/id', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      final errorMsg = Convert.jsonDecode(response.body)['message'];
      final formattedError = errorMsg != null ? '($errorMsg)' : '';
      throw Exception('Failed to get user profile $formattedError');
    }
    final json = Convert.jsonDecode(response.body);
    return UserProfile.fromJson(json);
  }

  Future<void> setUserProfile({Map<String, dynamic> userProfile}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/user/profile');
    final response = await client.post(url, headers: headers, body: {
      'id': user.uid,
      'profile': Convert.jsonEncode(userProfile),
    });
    if (response.statusCode != 200) {
      final errorMsg = Convert.jsonDecode(response.body)['message'];
      final formattedError = errorMsg != null ? '($errorMsg)' : '';
      throw Exception('Failed to set user profile $formattedError');
    }
  }

  Future<bool> validateDevicePrivateKey({String scannedKey}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/challenge');
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get private key challenge');
    }
    final json = Convert.jsonDecode(response.body);
    print(response.body);
    final challengeString = json['challengeString'] as String;
    final encryptedString = json['encryptedString'] as String;
    try {
      final privateKey = Crypton.RSAPrivateKey.fromString(scannedKey);
      final decryptedString = await cse.decryptChallengeString(
          encrypted: encryptedString, privateKey: privateKey);
      print(decryptedString);
      return decryptedString == challengeString;
    } catch (e) {
      return false;
    }
  }

  Future<void> _setOwnDEK() async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/user/dek');
    final encryptedDEK = await cse.encryptOwnerDEK();
    final response = await client.post(url, headers: headers, body: {
      'id': user.uid,
      'dek': encryptedDEK.toString(),
    });
  }

  Future<void> updateDEKFromServer() async {
    final hasPKPair = await cse.hasKeyPair();
    if (!hasPKPair) {
      throw Exception(
          'Asymmetric key must be set before updating DEK from server');
    }
    final query = {
      'id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/user/dek', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get own dek');
    }
    final json = Convert.jsonDecode(response.body);
    final encryptedDek = json['dek'];
    if (encryptedDek == null) {
      throw Exception('DEK request returned no value');
    }
    await cse.setDEK(encryptedDek: encryptedDek);
  }

  Future<List<WidgetData>> getHabitData() async {
    final query = {
      'id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/habit_data', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get own habit data');
    }
    final json = Convert.jsonDecode(response.body) as Map<String, dynamic>;
    if (!json.containsKey('habit_data')) {
      throw Exception(
          'Failed to get own habit data: No habit data in response');
    }
    if (json['habit_data'] == null) {
      return [];
    }
    final encryptedHabitData = json['habit_data'] as String;
    final habitDataPlainText = await cse.decryptText(text: encryptedHabitData);
    final decodedHabitData = Convert.jsonDecode(habitDataPlainText) as List;
    if (!(decodedHabitData is List)) {
      throw Exception('Own Decrypted Habit Data was malformed');
    }
    return decodedHabitData
        .map((habitWidget) => widgetDataFromJson(habitWidget))
        .toList();
  }

  Future<List<WidgetData>> getFollowingHabitData({String targetUserID}) async {
    final query = {
      'followee_id': targetUserID,
      'follower_id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/habit_data/following', query);
    final response = await client.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get habit data from user ($targetUserID)');
    }
    final json = Convert.jsonDecode(response.body) as Map<String, dynamic>;
    if (!json.containsKey('dek')) {
      throw Exception(
          'Failed to get habit data from user ($targetUserID): No DEK in response');
    }
    if (json['habit_data'] == null) {
      return [];
    }
    final encryptedDEK = EncryptedDEK.fromString(json['dek']);
    final dek = await cse.decryptOtherDEK(encryptedDEK: encryptedDEK);
    final decryptedHabitData =
        await cse.decryptText(text: json['habit_data'], usingKey: dek);
    final jsonHabitData = Convert.jsonDecode(decryptedHabitData) as List;
    if (!(jsonHabitData is List)) {
      throw Exception(
          'Decrypted Habit Data from ($targetUserID) was malformed');
    }
    return jsonHabitData
        .map((habitWidget) => widgetDataFromJson(habitWidget))
        .toList();
  }

  Future<void> setHabitData({List<WidgetData> habitData}) async {
    final mappedWidgets = habitData.map((e) => widgetDataToJson(e)).toList();
    final encodedHabitData = Convert.jsonEncode(mappedWidgets);
    final encryptedHabitData = await cse.encryptText(text: encodedHabitData);
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/habit_data');
    final response = await client.post(url, headers: headers, body: {
      'id': user.uid,
      'habit_data': encryptedHabitData,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to set habit data');
    }
  }

  Future<void> sendFollowRequest({String targetUserID}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/follow/requests');
    final response = await client.post(url, headers: headers, body: {
      'followee_id': targetUserID,
      'follower_id': user.uid,
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
      'followee_id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/follow/followers/requests', query);
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
      'follower_id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/follow/following/requests', query);
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
      'followee_id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/follow/followers', query);
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
      'follower_id': user.uid,
    };
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final url = Uri.https(apiBaseURL, '/follow/following', query);
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
    EncryptedDEK encryptedDEK;
    if (await cse.hasDEK()) {
      encryptedDEK = await cse.encryptOwnerDEK(
          usingPublicKey: targetUserPublicKey.toString());
    } else {
      encryptedDEK = EncryptedDEK(encrypted: '', iv: '');
    }
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/follow');
    final response = await client.post(url, headers: headers, body: {
      'followee_id': user.uid,
      'follower_id': targetUserID,
      'dek': encryptedDEK.toString(),
    });
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to approve follow request from user ($targetUserID)');
    }
  }

  Future<void> rejectFollowRequest({String targetUserID}) async {
    final headers = {
      HttpHeaders.authorizationHeader: await _getAuthHeader(),
    };
    final url = Uri.https(apiBaseURL, '/follow/requests');
    final response = await client.delete(url, headers: headers, body: {
      'followee_id': user.uid,
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
    final url = Uri.https(apiBaseURL, '/follow');
    final response = await client.delete(url, headers: headers, body: {
      'followee_id': user.uid,
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
    final url = Uri.https(apiBaseURL, '/follow');
    final response = await client.delete(url, headers: headers, body: {
      'followee_id': targetUserID,
      'follower_id': user.uid,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to remove follower ($targetUserID)');
    }
  }
}
