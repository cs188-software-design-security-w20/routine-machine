import 'package:flutter/material.dart';

class RingProgressBar extends StatelessWidget {
  final int currentCount;
  final int goalCount;
  String counterLabel;
  int ringColor;
  double percentComplete;
  // not sure how sizing is done in mobile dev so hard coding here
  double ringSize = 150;

  RingProgressBar({this.currentCount, this.goalCount, habitType, color}) {
    ringColor = color;
    // if current count <= 0, default to 0.01 so a little bit of the ring is visible
    percentComplete = currentCount > 0 ? currentCount / goalCount : 0.01;
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        children: <Widget>[
          Container(
            width: ringSize,
            height: ringSize,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(ringColor)),
              value: percentComplete,
              strokeWidth: 10,
            ),
          ),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: currentCount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 48.0,
                  height: 1.0,
                ),
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
            ),
          )
        ],
      ),
    );
  }
}
