import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'RingProgressBar.dart';
import '../../constants/Constants.dart' as Constants;
import '../pages/HabitDetailPage.dart';

class SmallWidgetView extends StatelessWidget {
  // final String routineName;
  // final String widgetType;
  // final int count;
  // final int goal;
  // final List<DateTime> checkIns;
  // final Color color;
  WidgetData data;

  SmallWidgetView({this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitDetailPage(
              data: data,
            ),
          ),
        );
      },
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
