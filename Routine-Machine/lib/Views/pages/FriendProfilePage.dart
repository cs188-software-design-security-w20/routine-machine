import 'package:flutter/material.dart';
import 'dart:io';
import 'package:routine_machine/Views/subviews/FriendWidgetList.dart';
import '../../constants/Constants.dart';
import '../components/TopBackBar.dart';
import '../../Models/FriendStatus.dart';
import '../../Models/UserProfile.dart';
import '../../Models/WidgetData.dart';

List<WidgetData> sampleWidgetData = [
  WidgetData(
    title: "Sample",
    widgetType: "weekly",
    color: 0xffffaabb,
    createdTime: new DateTime.now(),
    modifiedTime: new DateTime.now(),
    currentPeriodCounts: 15,
    periodicalGoal: 20,
    checkins: [new DateTime.now(), new DateTime.now()],
  ),
  WidgetData(
    title: "Pooop",
    widgetType: "daily",
    color: 0xFF7CD0FF,
    createdTime: new DateTime.now(),
    modifiedTime: new DateTime.now(),
    currentPeriodCounts: 8,
    periodicalGoal: 20,
    checkins: [new DateTime.now(), new DateTime.now()],
  ),
];

class FriendProfilePage extends StatefulWidget {
  final UserProfile friendProfile;
  FriendStatus friendStatus; // TODO: figure out what to do with this variable
  final Color userColor;

  FriendProfilePage({this.friendProfile, this.friendStatus, this.userColor});

  @override
  _FriendProfilePageState createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  Future<List<WidgetData>> _friendWidgetDataList;

  @override
  void initState() {
    super.initState();
    _friendWidgetDataList = _getFriendWidgetData();
  }

  Future<List<WidgetData>> _getFriendWidgetData() {
    // TODO: replace this with actual APIWrapper call
    return Future.delayed(new Duration(seconds: 2), () => sampleWidgetData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image here
              CircleAvatar(
                backgroundColor: widget.userColor,
                radius: 50,
                child: Text(
                  '${widget.friendProfile.firstName[0].toUpperCase()}',
                  style: TextStyle(
                    fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
                    fontSize: 47.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(
                      '${widget.friendProfile.firstName} ${widget.friendProfile.lastName}',
                      style: kTitle1Style,
                    ),
                    Text(
                      "@${widget.friendProfile.username}",
                      style: kCaptionLabelStyle,
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: _friendWidgetDataList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<WidgetData>> snapshot) {
                    Widget friendDataContent;
                    if (snapshot.hasData) {
                      friendDataContent = Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                        child: FriendWidgetList(
                          data: snapshot.data,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      friendDataContent =
                          Center(child: Text('Error loading follower data'));
                    } else {
                      friendDataContent =
                          Center(child: Text('Loading friend\'s data...'));
                    }
                    return friendDataContent;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
