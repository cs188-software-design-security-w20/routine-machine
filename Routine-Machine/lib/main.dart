import 'package:flutter/material.dart';
import 'package:routine_machine/RingProgressBar.dart';
import 'package:routine_machine/RoutineWidget.dart';

import './RingProgressBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine Machine',
      home: Scaffold(
        body: RingProgressBar(
          currentCount: 17,
          goalCount: 20,
          habitType: 'monthly',
          color: 0xFFC960FF,
        ),
      ),
    );
  }
}
