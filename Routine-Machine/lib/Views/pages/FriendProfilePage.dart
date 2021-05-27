import 'package:flutter/material.dart';
import 'package:routine_machine/Views/subviews/FriendWidgetList.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import '../../constants/Constants.dart';
import '../components/TopBackBar.dart';
import '../../Models/FriendStatus.dart';
import '../../Models/UserProfile.dart';
import '../../Models/WidgetData.dart';
import '.././../constants/Constants.dart' as Constants;

class FriendProfilePage extends StatefulWidget {
  final APIWrapper api = APIWrapper();
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
    return widget.api
        .getFollowingHabitData(targetUserID: widget.friendProfile.userID);
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
                    fontFamily: 'SF Pro Text',
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
                      friendDataContent = Center(
                        child: Text(
                          'Unable to view habit data.\nSend a follow request to see their habits :)',
                          style: Constants.kBodyLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      friendDataContent = Center(
                        child: Text(
                          'Loading friend\'s data...',
                          style: Constants.kBodyLabelStyle,
                        ),
                      );
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
