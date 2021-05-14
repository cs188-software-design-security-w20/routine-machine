import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;
import '../components/RingProgressBar.dart';
import '../components/TopBackBar.dart';
import '../subviews/CheckInList.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:routine_machine/Models/WidgetData.dart';

class HabitDetailPage extends StatefulWidget {
  final String routineName;
  final String widgetType;
  final int count;
  final int goal;
  final List<DateTime> checkIns;
  final Color color;

  HabitDetailPage({
    this.routineName,
    this.widgetType,
    this.count,
    this.goal,
    this.checkIns,
    this.color,
  });
  // WidgetData data;
  // HabitDetailPage({this.data});

  @override
  _HabitDetailPageState createState() => _HabitDetailPageState(this.count);
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  _HabitDetailPageState(this._count);

  int _count;

  void _incrementCount() {
    setState(() {
      _count++;
      // widget.data.currentPeriodCounts += 1;
      // widget.data.checkins.add(DateTime.now());
    });
  }

  void _decrementCount() {
    setState(() {
      _count--;
      // widget.data.currentPeriodCounts -= 1;
      // widget.data.checkins.removeLast();
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
          child: SlidingUpPanel(
            panel: Center(
              child: Text("Edit page"),
            ),
            body: Column(
              children: [
                Text(
                  widget.routineName,
                  // widget.data.title,
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
                      goalCount: widget.goal,
                      habitType: widget.widgetType,
                      color: widget.color,
                      // goalCount: widget.data.periodicalGoal,
                      // habitType: widget.data.widgetType,
                      // color: Color(widget.data.color),
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
                  checkIns: widget.checkIns,
                  color: widget.color,
                  // checkIns: widget.data.checkins,
                  // color: Color(widget.data.color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
