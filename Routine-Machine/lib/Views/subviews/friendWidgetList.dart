import 'package:flutter/material.dart';
import 'package:routine_machine/Views/components/RingProgressBar.dart';
import '../../Models/WidgetData.dart';
import '../../constants/Constants.dart' as Constants;

class FriendWidgetList extends StatelessWidget {
  final List<WidgetData> data;

  FriendWidgetList({this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          for (var d in this.data) LongWidgetView(d),
        ],
      ),
    );
  }
}

class LongWidgetView extends StatelessWidget {
  final WidgetData data;

  LongWidgetView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      height: 60,
      width: double.infinity,
      decoration: Constants.kCardDecorationStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RingProgressBar(
            currentCount: data.currentPeriodCounts,
            goalCount: data.periodicalGoal,
            habitType: data.widgetType,
            color: Color(data.color),
            showText: false,
          ),
          Column(
            children: [
              Text(
                  "${data.title} ${data.currentPeriodCounts}${data.periodicalGoal}"),
              if (data.checkins.length > 0)
                Text("Last checked at ${data.checkins.last}")
            ],
          )
        ],
      ),
    );
  }
}
