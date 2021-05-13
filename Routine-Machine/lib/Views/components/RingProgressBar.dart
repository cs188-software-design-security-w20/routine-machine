import 'package:flutter/material.dart';
import '../../constants/Constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class RingProgressBar extends StatelessWidget {
  RingProgressBar(
      {this.currentCount,
      this.goalCount,
      habitType,
      color,
      this.showText = true,
      this.ringSize = 110}) {
    ringColor = color;

    // if current count <= 0, default to 0.01 so a little bit of the ring is visible
    if (currentCount > goalCount) {
      _percentComplete = 1;
    } else if (currentCount <= 0) {
      _percentComplete = 0.01;
    } else {
      _percentComplete = currentCount / goalCount;
    }
    // percentComplete = currentCount > 0 ? currentCount / goalCount : 0.01;
    if (habitType == 'daily') {
      // perhaps want to enumerate these types somewhere
      counterLabel = 'today';
    } else if (habitType == 'weekly') {
      counterLabel = 'this week';
    } else if (habitType == 'monthly') {
      counterLabel = 'this month';
    } else {
      throw ArgumentError([
        'Invalid habit type $habitType\n Must choose from "daily", "weekly", or "monthly"'
      ]);
    }
  }

  String counterLabel;
  final int currentCount;
  final int goalCount;
  double _percentComplete;
  Color ringColor;
  bool showText;
  // not sure how sizing is done in mobile dev so hard coding here
  double ringSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: ringSize,
              height: ringSize,
              child: CircularPercentIndicator(
                animateFromLastPercent: true,
                animation: true,
                animationDuration: 200,
                radius: ringSize,
                lineWidth: 6.0,
                percent: _percentComplete,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: ringColor.withOpacity(0.3),
                progressColor: ringColor,
              ),
            ),
          ),
          Center(
            child: _percentComplete == 1
                ? Icon(
                    SFSymbols.checkmark_alt,
                    size: 45,
                    color: ringColor,
                  )
                : this.showText
                    ? RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: currentCount.toString(),
                          style: kLargeTitleStyle,
                          children: [
                            TextSpan(
                              text: '/$goalCount\n',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24.0,
                              ),
                            ),
                            TextSpan(
                              text: counterLabel,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(""),
          )
        ],
      ),
    );
  }
}
