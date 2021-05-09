import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../components/RingProgressBar.dart';
import '../components/TopBackBar.dart';
import '../subviews/CheckInList.dart';
import '../../Models/WidgetData.dart';

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
  // WidgetData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(24),
          width: double.infinity,
          decoration: Constants.kCardDecorationStyle,
          child: Column(
            children: [
              Text(
                widget.data.title,
                style: Constants.kLargeTitleStyle,
              ),
              RingProgressBar(
                currentCount: widget.data.currentPeriodCounts,
                goalCount: widget.data.periodicalGoal,
                habitType: widget.data.widgetType,
                color: Color(widget.data.color),
              ),
              CheckInList(
                checkIns: widget.data.checkins,
                color: Color(widget.data.color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
