import 'package:flutter/material.dart';
import 'RingProgressBar.dart';
import '../../constants/Constants.dart' as Constants;
import '../pages/HabitDetailPage.dart';

class SmallWidgetView extends StatelessWidget {
  final String routineName;
  final String widgetType;
  final int count;
  final int goal;
  final List<DateTime> checkIns;
  final Color color;

  SmallWidgetView(
      {this.routineName,
      this.widgetType,
      this.count,
      this.goal,
      this.checkIns = const <DateTime>[],
      this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitDetailPage(
              routineName: this.routineName,
              widgetType: this.widgetType,
              count: this.count,
              goal: this.goal,
              checkIns: this.checkIns,
              color: this.color,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: Constants.kCardDecorationStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                routineName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Constants.kCardTitleStyle,
              ),
            ),
            GestureDetector(
              onTap: () => print('increment count!'),
              child: RingProgressBar(
                currentCount: count,
                goalCount: goal,
                habitType: widgetType,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
