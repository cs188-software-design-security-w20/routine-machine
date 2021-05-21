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
    this.color,
    this.createdTime,
    this.modifiedTime,
    this.currentPeriodCounts,
    this.periodicalGoal,
    this.checkins,
  });

  String title;
  String widgetType;
  int color;
  DateTime createdTime;
  DateTime modifiedTime;
  int currentPeriodCounts;
  int periodicalGoal;
  List<DateTime> checkins;

  factory WidgetData.fromJson(Map<String, dynamic> json) {
    return WidgetData(
      title: json["title"],
      widgetType: json["widgetType"],
      color: json["color"],
      createdTime: _fromJson(json["createdTime"]),
      modifiedTime: _fromJson(json["modifiedTime"]),
      currentPeriodCounts: json["currentPeriodCounts"],
      periodicalGoal: json["periodicalGoal"],
      checkins: json['checkins'].map<DateTime>((x) => DateTime.now()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "widgetType": widgetType,
        "color": color,
        "createdTime": _toJson(createdTime),
        "modifiedTime": _toJson(modifiedTime),
        "currentPeriodCounts": currentPeriodCounts,
        "periodicalGoal": periodicalGoal,
        "checkins": checkins.map((checkin) => _toJson(checkin)).toList(),
      };

  static DateTime _fromJson(int x) => DateTime.fromMillisecondsSinceEpoch(x);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;

  static WidgetData widgetSample1 = WidgetData(
      title: "Drink Water",
      widgetType: "daily",
      color: 0xFF7CD0FF,
      createdTime: new DateTime.now(),
      modifiedTime: new DateTime.now(),
      currentPeriodCounts: 1,
      periodicalGoal: 6,
      checkins: [new DateTime.now(), new DateTime.now()]);
  static WidgetData widgetSample2 = WidgetData(
      title: "Exercise",
      widgetType: "weekly",
      color: 0xFFFFDF6B,
      createdTime: new DateTime.now(),
      modifiedTime: new DateTime.now(),
      currentPeriodCounts: 2,
      periodicalGoal: 4,
      checkins: [new DateTime.now(), new DateTime.now()]);
  static WidgetData widgetSample3 = WidgetData(
      title: "Read the News",
      widgetType: "monthly",
      color: 0xFFFF93BA,
      createdTime: new DateTime.now(),
      modifiedTime: new DateTime.now(),
      currentPeriodCounts: 11,
      periodicalGoal: 20,
      checkins: [new DateTime.now(), new DateTime.now()]);
}
