import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckInItem extends StatelessWidget {
  final int color;
  String checkInTime;
  CheckInItem({checkInTime, this.color}) {
    this.checkInTime = DateFormat('EE, MMMM d').add_jm().format(checkInTime);
  }
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '\u2022 ',
            style: TextStyle(
              color: Color(this.color),
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
