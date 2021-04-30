import 'package:flutter/material.dart';
import 'package:routine_machine/Views/components/RingProgressBar.dart';

class SmallWidgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Spacer(),
            Text(
              "Widget Title",
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Spacer(),
            RingProgressBar(
              currentCount: 13,
              goalCount: 13,
              habitType: 'monthly',
              color: 0xFFC960FF,
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
