import 'package:flutter/material.dart';

import 'Models/SampleFollowTileData.dart';
import 'constants/Palette.dart' as Palette;

import 'Views/components/RingProgressBar.dart';
import 'Views/components/BottomNavBar.dart';
import 'Views/components/ProfileBarView.dart';
import 'Views/subviews/CheckInList.dart';
import 'Views/subviews/FollowingTileList.dart';
import 'Views/components/SmallWidgetView.dart';

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
    color: Palette.pink,
  ),
  SampleFollowTileData(
    firstName: 'Lee',
    lastName: 'Jieun',
    routineName: 'Practice singing',
    lastCheckIn: new DateTime.now().subtract(new Duration(minutes: 15)),
    color: Palette.purple,
  ),
  SampleFollowTileData(
    firstName: 'Erika',
    lastName: 'Shen',
    routineName: 'Hike',
    lastCheckIn: new DateTime.now().subtract(new Duration(days: 1)),
    color: Palette.blue,
  ),
];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "SF Pro Rounded"),
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
              Row(
                children: [
                  Spacer(),
                  SmallWidgetView(),
                  Spacer(),
                  SmallWidgetView(),
                  Spacer(),
                ],
              ),
              // FollowingTileList(followingList: sampleFollowingList),
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
