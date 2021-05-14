import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;
import '../components/RingProgressBar.dart';
import '../components/TopBackBar.dart';
import '../subviews/CheckInList.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:routine_machine/Models/WidgetData.dart';

class HabitDetailPage extends StatefulWidget {
  // final String routineName;
  // final String widgetType;
  // final int count;
  // final int goal;
  // final List<DateTime> checkIns;
  // final Color color;
  WidgetData data;
  HabitDetailPage({this.data});

  @override
  _HabitDetailPageState createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  int _count;
  WidgetData data;

  _HabitDetailPageState({this.data});

  void _incrementCount() {
    setState(() {
      // _count++;\
      this.data.currentPeriodCounts += 1;
      this.data.checkins.add(DateTime.now());
    });
  }

  void _decrementCount() {
    setState(() {
      this.data.currentPeriodCounts -= 1;
      this.data.checkins.removeLast();
    });
  }

  // WidgetData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(passBack: _count),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
            padding: EdgeInsets.all(24),
            width: double.infinity,
            decoration: Constants.kCardDecorationStyle,
            child: Column(
              children: [
                Text(
                  data.title,
                  style: Constants.kLargeTitleStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_rounded),
                      color: Palette.grey,
                      iconSize: 36,
                      onPressed: _decrementCount,
                    ),
                    RingProgressBar(
                      currentCount: _count,
                      goalCount: data.periodicalGoal,
                      habitType: data.widgetType,
                      color: Color(data.color),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_rounded),
                      color: Palette.grey,
                      iconSize: 36,
                      onPressed: _incrementCount,
                    ),
                  ],
                ),
                CheckInList(
                  checkIns: data.checkins,
                  color: Color(data.color),
                )
              ],
            )),
      ),
    );
  }
}
