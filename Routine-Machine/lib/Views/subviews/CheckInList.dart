import 'package:flutter/material.dart';
import '../components/CheckInItem.dart';
import '../components/GreyContainer.dart';

class CheckInList extends StatelessWidget {
  final List<DateTime> checkIns;
  final int color;

  CheckInList({this.checkIns, this.color});

  @override
  Widget build(BuildContext context) {
    return GreyContainer(
      child: ListView(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        children: checkIns.isEmpty
            // if no check ins, show this default message text
            ? [Text('No recent activity', style: TextStyle(fontSize: 18.0))]
            : checkIns
                .map(
                    (time) => CheckInItem(checkInTime: time, color: this.color))
                .toList(),
      ),
    );
  }
}
