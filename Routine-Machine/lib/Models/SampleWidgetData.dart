import 'package:flutter/material.dart';

class SampleWidgetData {
  final String routineName;
  final String widgetType;
  final int count;
  final int goal;
  final List<DateTime> checkIns;
  final Color color;

  SampleWidgetData(
      {this.routineName,
      this.widgetType,
      this.count,
      this.goal,
      this.checkIns,
      this.color});
}
