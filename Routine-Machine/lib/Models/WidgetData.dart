// To parse this JSON data, do
//
//     final widgetData = widgetDataFromJson(jsonString);

import 'dart:convert';

WidgetData widgetDataFromJson(String str) =>
    WidgetData.fromJson(json.decode(str));

String widgetDataToJson(WidgetData data) => json.encode(data.toJson());

class WidgetData {
  WidgetData({
    this.title,
    this.widgetType,
    this.createdTime,
    this.modifiedTime,
    this.currentPeriodCounts,
    this.periodicalGoal,
    this.checkins,
  });

  String title;
  String widgetType;
  int createdTime;
  int modifiedTime;
  int currentPeriodCounts;
  int periodicalGoal;
  List<int> checkins;

  factory WidgetData.fromJson(Map<String, dynamic> json) => WidgetData(
        title: json["title"],
        widgetType: json["widgetType"],
        createdTime: json["createdTime"],
        modifiedTime: json["modifiedTime"],
        currentPeriodCounts: json["currentPeriodCounts"],
        periodicalGoal: json["periodicalGoal"],
        checkins: List<int>.from(json["checkins"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "widgetType": widgetType,
        "createdTime": createdTime,
        "modifiedTime": modifiedTime,
        "currentPeriodCounts": currentPeriodCounts,
        "periodicalGoal": periodicalGoal,
        "checkins": List<dynamic>.from(checkins.map((x) => x)),
      };
}

/*
{
"title": "t",
"widgetType": "a",
"createdTime": 1620519012983,
"modifiedTime": 1620519012983,
"currentPeriodCounts": 123,
"periodicalGoal": 100,
"checkins": [ 123, 3123]
}
*/
