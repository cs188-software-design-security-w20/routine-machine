// To parse this JSON data, do
//
//     final widgetData = widgetDataFromJson(jsonString);

import 'dart:convert';
import 'package:mock_data/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime createdTime;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime modifiedTime;
  int currentPeriodCounts;
  int periodicalGoal;
  List<DateTime> checkins;

  factory WidgetData.fromJson(Map<String, dynamic> json) => WidgetData(
        title: json["title"],
        widgetType: json["widgetType"],
        color: json["color"],
        createdTime: json["createdTime"],
        modifiedTime: json["modifiedTime"],
        currentPeriodCounts: json["currentPeriodCounts"],
        periodicalGoal: json["periodicalGoal"],
        checkins: List<DateTime>.from(json["checkins"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "widgetType": widgetType,
        "color": color,
        "createdTime": createdTime,
        "modifiedTime": modifiedTime,
        "currentPeriodCounts": currentPeriodCounts,
        "periodicalGoal": periodicalGoal,
        "checkins": List<dynamic>.from(checkins.map((x) => x)),
      };

  static DateTime _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;

  static WidgetData widgetSample1 = WidgetData(
    title: "Drink Water",
    widgetType: "daily",
    color: 0xFF7CD0FF,
    createdTime: new DateTime.now(),
    modifiedTime: new DateTime.now(),
    currentPeriodCounts: 1,
    periodicalGoal: 6,
    checkins: [new DateTime.now(), new DateTime.now()],
  );
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

/*
{
"title": "t",
"widgetType": "a",
"color": 0x12313,
"createdTime": 1620519012983,
"modifiedTime": 1620519012983,
"currentPeriodCounts": 123,
"periodicalGoal": 100,
"checkins": [ 123, 3123]
}
*/
