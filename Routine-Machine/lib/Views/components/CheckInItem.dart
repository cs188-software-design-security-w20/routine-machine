import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckInItem extends StatelessWidget {
  final Color color;
  String checkInTime;
  CheckInItem({checkInTime, this.color}) {
    this.checkInTime = DateFormat('EE, MMMM d').add_jm().format(checkInTime);
  }
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black.withOpacity(0.8),
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '\u2022 ',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Check-in on $checkInTime',
          ),
        ],
      ),
    );
  }
}
