import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../components/RingProgressBar.dart';
import '../components/TopBackBar.dart';
import '../subviews/CheckInList.dart';

class HabitDetailPage extends StatelessWidget {
  final String routineName;
  final String widgetType;
  final int count;
  final int goal;
  final List<DateTime> checkIns;
  final Color color;

  HabitDetailPage(
      {this.routineName,
      this.widgetType,
      this.count,
      this.goal,
      this.checkIns,
      this.color});

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
                  routineName,
                  style: Constants.kLargeTitleStyle,
                ),
                RingProgressBar(
                  currentCount: count,
                  goalCount: goal,
                  habitType: widgetType,
                  color: color,
                ),
                CheckInList(
                  checkIns: checkIns,
                  color: color,
                )
              ],
            )),
      ),
    );
  }
}
