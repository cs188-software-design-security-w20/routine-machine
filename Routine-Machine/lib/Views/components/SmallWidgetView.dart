import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'RingProgressBar.dart';
import '../../constants/Constants.dart' as Constants;
import '../pages/HabitDetailPage.dart';


class SmallWidgetView extends StatelessWidget {
  WidgetData data;
// =======
// class SmallWidgetView extends StatefulWidget {
//   final String routineName;
//   final String widgetType;
//   final int count;
//   final int goal;
//   final List<DateTime> checkIns;
//   final Color color;
// >>>>>>> master

  SmallWidgetView({this.data});

  @override
  _SmallWidgetViewState createState() => _SmallWidgetViewState();
}

class _SmallWidgetViewState extends State<SmallWidgetView> {
  int count = 0; // eventually just fetch this state

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
          routineName: widget.routineName,
          widgetType: widget.widgetType,
          count: count,
          goal: widget.goal,
          checkIns: widget.checkIns,
          color: widget.color,
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
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Constants.kCardTitleStyle,
                ),
              ),
              GestureDetector(
                onTap: () => print('increment count!'),
                child: RingProgressBar(
                  currentCount: data.currentPeriodCounts,
                  goalCount: data.periodicalGoal,
                  habitType: data.widgetType,
                  color: Color(data.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
