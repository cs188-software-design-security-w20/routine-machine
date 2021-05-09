import 'package:flutter/material.dart';
import 'package:routine_machine/Models/UserData.dart';
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
      body: Column(
        children: [
          // Image here
          Text(friendData.profile.userName),
          Text("@${friendData.profile.userId}")
        ],
      ),
    );
  }
}
