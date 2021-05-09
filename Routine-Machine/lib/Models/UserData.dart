import 'dart:convert';
import 'WidgetData.dart';
import 'UserProfile.dart';

class UserData {
  UserData({
    this.data,
    this.profile,
  });

  List<WidgetData> data;
  UserProfile profile;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        data: List<WidgetData>.from(
            json["data"].map((x) => WidgetData.fromJson(x))),
        profile: UserProfile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "profile": profile.toJson(),
      };
}
