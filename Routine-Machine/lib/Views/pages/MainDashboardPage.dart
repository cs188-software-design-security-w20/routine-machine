import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import '../subviews/WidgetList.dart';
import '../components/ProfileBarView.dart';
import '../../constants/Palette.dart' as Palette;
import '../../Models/SampleWidgetData.dart';

final List<SampleWidgetData> sampleWidgetList = [
  SampleWidgetData(
    routineName: 'Drink Water',
    widgetType: 'daily',
    count: 2,
    goal: 5,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.blue,
  ),
  SampleWidgetData(
    routineName: 'Workout',
    widgetType: 'weekly',
    count: 3,
    goal: 5,
    checkIns: [],
    color: Palette.pink,
  ),
  SampleWidgetData(
    routineName: 'Read a Book',
    widgetType: 'monthly',
    count: 11,
    goal: 20,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.green,
  ),
  SampleWidgetData(
    routineName: 'Sleep Early',
    widgetType: 'weekly',
    count: 2,
    goal: 7,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.yellow,
  ),
  SampleWidgetData(
    routineName: 'Drink Water',
    widgetType: 'daily',
    count: 2,
    goal: 5,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.blue,
  ),
  SampleWidgetData(
    routineName: 'Workout',
    widgetType: 'weekly',
    count: 3,
    goal: 5,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.pink,
  ),
  SampleWidgetData(
    routineName: 'Read a Book',
    widgetType: 'monthly',
    count: 11,
    goal: 20,
    checkIns: [],
    color: Palette.green,
  ),
  SampleWidgetData(
    routineName: 'Sleep Early',
    widgetType: 'weekly',
    count: 2,
    goal: 7,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.yellow,
  ),
  SampleWidgetData(
    routineName: 'Study More You Dummy Get Up and Work',
    widgetType: 'weekly',
    count: 2,
    goal: 7,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.yellow,
  ),
];

final List<WidgetData> samples = [
  WidgetData.widgetSample1,
  WidgetData.widgetSample2,
  WidgetData.widgetSample3,
  WidgetData.widgetSample1,
  WidgetData.widgetSample2,
  WidgetData.widgetSample3,
];

class MainDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ProfileBarView(
                firstName: 'Jody',
                lastName: 'Lin',
              ),
            ),
            WidgetList(
              widgetList: samples,
            ),
          ],
        ),
      ),
    );
  }
}
