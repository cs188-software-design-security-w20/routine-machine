import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/RingProgressBar.dart';
import 'package:routine_machine/RoutineWidget.dart';
import './constants/Palette.dart' as Palette;
import './RingProgressBar.dart';
import './CheckInList.dart';
import './BottomNavBar.dart';
import './ProfileBarView.dart';

// sample data to demo the check in list
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
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ProfileBarView(firstName: 'Jody', lastName: 'Lin'),
              CheckInList(
                checkIns: sampleCheckIns,
                color: 0xFFC960FF,
              ),
              RingProgressBar(
                currentCount: 17,
                goalCount: 20,
                habitType: 'monthly',
                color: 0xFFC960FF,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.primary,
          child: Icon(Icons.add_rounded),
          onPressed: () => {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
