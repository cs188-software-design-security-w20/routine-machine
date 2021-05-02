import 'package:flutter/material.dart';
import 'dart:io';

import '../../constants/Palette.dart' as Palette;
import '../../constants/Constants.dart' as Constants;
import '../../Models/SampleFollowTileData.dart';
import '../subviews/FollowingTileList.dart';

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

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final searchController = TextEditingController();
  String _page = 'following';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  void _switchToFollowers() {
    if (_page != 'followers') {
      setState(() {
        _page = 'followers';
      });
    }
  }

  void _switchToFollowing() {
    if (_page != 'following') {
      setState(() {
        _page = 'following';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Platform.isAndroid
              ? SizedBox(height: 36)
              : null, // for Jody's phone lmao - i have camera overlap
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _switchToFollowing,
                child: Text(
                  'Following',
                  style: _page == 'following'
                      ? Constants.kLargeTitleStyle
                      : Constants.kUnselectedTitleStyle,
                ),
              ),
              GestureDetector(
                onTap: _switchToFollowers,
                child: Text(
                  'Followers',
                  style: _page == 'followers'
                      ? Constants.kLargeTitleStyle
                      : Constants.kUnselectedTitleStyle,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Search for friends...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () {
                    // TODO: update so search for people
                    print('search for ${searchController.text}!');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _page == 'following'
                ? FollowingTileList(
                    followingList: sampleFollowingList,
                  )
                : Center(
                    // TODO: replace with followers list
                    child: Text('followers page'),
                  ),
          ),
        ],
      ),
    );
  }
}
