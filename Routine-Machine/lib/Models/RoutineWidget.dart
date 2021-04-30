import 'dart:ui';

class RoutineData {
  DateTime startingTime; // Time period
  int count;
  List<DateTime> checkIns;
}

class RoutineSettings {}

class RoutineWidget {
  String routineName;
  String widgetType; // ("daily", "weekly", "monthly")
  DateTime createTime;
  DateTime lastUpdateTime;
  int goal;
  List<RoutineData> data;
  RoutineSettings settings;
  Color themeColor;
}
