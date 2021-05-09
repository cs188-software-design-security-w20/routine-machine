import 'package:flutter/material.dart';
import 'dart:io';
import 'package:routine_machine/Models/UserData.dart';
import 'package:routine_machine/Views/subviews/friendWidgetList.dart';
import '../../constants/Palette.dart' as Palette;
import '../../constants/Constants.dart';
import '../components/TopBackBar.dart';
import '../../Models/FriendStatus.dart';
import '../../Models/UserData.dart';

class FriendProfilePage extends StatelessWidget {
  final UserData friendData;
  FriendStatus friendStatus;

  FriendProfilePage({this.friendData, this.friendStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image here
              CircleAvatar(
                backgroundColor: Palette.primary,
                radius: 50,
                child: Text(
                  this.friendData.profile.alias[0].toUpperCase(),
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
                      friendData.profile.alias,
                      style: kTitle1Style,
                    ),
                    Text(
                      "@${friendData.profile.username}",
                      style: kCaptionLabelStyle,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: FriendWidgetList(
                  data: friendData.data,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
