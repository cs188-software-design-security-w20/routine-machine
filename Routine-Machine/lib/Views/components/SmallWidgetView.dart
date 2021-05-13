import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'RingProgressBar.dart';
import '../../constants/Constants.dart' as Constants;
import '../pages/HabitDetailPage.dart';

class SmallWidgetView extends StatefulWidget {
  final WidgetData data;

  SmallWidgetView({this.data});

  @override
  _SmallWidgetViewState createState() => _SmallWidgetViewState();
}

class _SmallWidgetViewState extends State<SmallWidgetView> {
  int count = 0; // eventually just fetch this state

  @override
  void initState() {
    super.initState();
    count = widget.data.currentPeriodCounts;
  }

  void _incrementCount() {
    setState(() {
      this.count++;
    });
  }

  void _buildDetailPageAndAwaitCount(BuildContext context) async {
    // when the detail page is popped
    // it will return the updated value of count
    // then we will set the state to match this value
    final updatedCount = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitDetailPage(
          routineName: widget.data.title,
          widgetType: widget.data.widgetType,
          count: count,
          goal: widget.data.periodicalGoal,
          checkIns: widget.data.checkins,
          color: Color(widget.data.color),
        ),
      ),
    );
    setState(() {
      count = updatedCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _buildDetailPageAndAwaitCount(context),
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: Constants.kCardDecorationStyle,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  widget.data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Constants.kCardTitleStyle,
                ),
              ),
              GestureDetector(
                onTap: _incrementCount,
                child: RingProgressBar(
                  currentCount: count,
                  goalCount: widget.data.periodicalGoal,
                  habitType: widget.data.widgetType,
                  color: Color(widget.data.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
