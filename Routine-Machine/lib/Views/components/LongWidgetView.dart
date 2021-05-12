import 'package:flutter/material.dart';
import '../../Views/components/RingProgressBar.dart';
import '../../Models/WidgetData.dart';
import '../../constants/Constants.dart' as Constants;
import 'package:timeago/timeago.dart' as timeago;

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
                      Text(
                          "Last checked at ${timeago.format(data.checkins.last)}")
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
