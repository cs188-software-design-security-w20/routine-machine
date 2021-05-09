import 'package:flutter/material.dart';
import 'package:routine_machine/Views/components/RingProgressBar.dart';
import '../../Models/WidgetData.dart';
import '../../constants/Constants.dart' as Constants;

class FriendWidgetList extends StatelessWidget {
  final List<WidgetData> data;

  FriendWidgetList({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 20,
        children: [
          for (var d in this.data) LongWidgetView(d),
          for (var d in this.data) LongWidgetView(d),
          for (var d in this.data) LongWidgetView(d),
          for (var d in this.data) LongWidgetView(d),
        ],
      ),
    );
  }
}

class LongWidgetView extends StatelessWidget {
  final WidgetData data;
  final double rowHeight = 90;
  final double paddingRate = 0.15;

  LongWidgetView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingRate * rowHeight),
      height: rowHeight,
      width: MediaQuery.of(context).size.width,
      decoration: Constants.kCardDecorationStyle,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RingProgressBar(
              currentCount: data.currentPeriodCounts,
              goalCount: data.periodicalGoal,
              habitType: data.widgetType,
              color: Color(data.color),
              showText: false,
              ringSize: (1 - 2 * paddingRate) * rowHeight,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.title} ${data.currentPeriodCounts}/${data.periodicalGoal}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Constants.kTitle2Style,
                    ),
                    if (data.checkins.length > 0)
                      Text("Last checked at ${data.checkins.last}")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
