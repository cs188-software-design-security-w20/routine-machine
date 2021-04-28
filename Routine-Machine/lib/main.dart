import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/RingProgressBar.dart';
import 'package:routine_machine/RoutineWidget.dart';
import 'package:routine_machine/SampleFollowTileData.dart';

import './constants/Palette.dart' as Palette;
import './RingProgressBar.dart';
import './CheckInList.dart';
import './BottomNavBar.dart';
import './ProfileBarView.dart';
import 'FollowingTileList.dart';

// sample data to demo the check in list
final sampleCheckIns = <DateTime>[
  new DateTime.now(),
  new DateTime.utc(2021, 4, 20),
  new DateTime.utc(2020, 4, 30),
];

final List<SampleFollowTileData> sampleFollowingList = [
  SampleFollowTileData(
    firstName: 'Spencer',
    lastName: 'Jin',
    routineName: 'Workout',
    lastCheckIn: new DateTime.now(),
    color: Colors.pink,
  ),
  SampleFollowTileData(
    firstName: 'Lee',
    lastName: 'Jieun',
    routineName: 'Practice singing',
    lastCheckIn: new DateTime.now().subtract(new Duration(minutes: 15)),
    color: Colors.purple,
  ),
  SampleFollowTileData(
    firstName: 'Erika',
    lastName: 'Shen',
    routineName: 'Hike',
    lastCheckIn: new DateTime.now().subtract(new Duration(days: 1)),
    color: Colors.green,
  ),
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
              FollowingTileList(followingList: sampleFollowingList),
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
