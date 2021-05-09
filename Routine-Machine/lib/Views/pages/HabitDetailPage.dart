import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;
import '../components/RingProgressBar.dart';
import '../components/TopBackBar.dart';
import '../subviews/CheckInList.dart';

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

  @override
  _HabitDetailPageState createState() => _HabitDetailPageState(this.count);
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  int _count;

  _HabitDetailPageState(this._count);

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _decrementCount() {
    setState(() {
      _count--;
    });
  }

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
                  widget.routineName,
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
                )
              ],
            )),
      ),
    );
  }
}
