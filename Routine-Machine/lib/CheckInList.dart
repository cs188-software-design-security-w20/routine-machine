import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './GreyContainer.dart';

class CheckInItem extends StatelessWidget {
  String checkInTime;
  CheckInItem({checkInTime}) {
    this.checkInTime = DateFormat().add_MEd().add_jm().format(checkInTime);
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
              color: Colors.blue,
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

class CheckInList extends StatelessWidget {
  final List<DateTime> checkIns;

  CheckInList({this.checkIns});

  @override
  Widget build(BuildContext context) {
    return GreyContainer(
      child: ListView(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        children:
            checkIns.map((time) => CheckInItem(checkInTime: time)).toList(),
      ),
    );
  }
}
