import 'package:flutter/material.dart';
import 'package:routine_machine/RoutineWidget.dart';

import './CheckInList.dart';

final sampleCheckIns = <DateTime>[
  new DateTime.now(),
  new DateTime.utc(2021, 4, 20),
  new DateTime.utc(2020, 4, 30),
];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine Machine',
      home: Scaffold(
        appBar: AppBar(title: Text('test')),
        body: CheckInList(checkIns: sampleCheckIns),
      ),
    );
  }
}
