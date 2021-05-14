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
      body: Container(
        width: double.infinity,
        decoration: Constants.kCardDecorationStyle,
        child: SlidingUpPanel(
          backdropEnabled: true,
          maxHeight: 0.8 * MediaQuery.of(context).size.height,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.0),
            topRight: Radius.circular(34.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Constants.kShadowColor,
                offset: Offset(0, -12),
                blurRadius: 30),
          ],
          // TODO: Edit page here
          panel: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 20),
                  child: Container(
                    width: 42.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFC5CBD6),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Habit settings",
                  style: Constants.kTitle2Style,
                ),
              ),
              // TODO: Add more settings here
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TopBackBar(passBack: _count),
                Text(
                  widget.routineName,
                  // widget.data.title,
                  style: Constants.kLargeTitleStyle,
                ),
                SizedBox(
                  height: 26,
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
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_rounded),
                      color: Palette.grey,
                      iconSize: 36,
                      onPressed: _incrementCount,
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                CheckInList(
                  checkIns: widget.checkIns,
                  color: widget.color,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
