import 'package:flutter/material.dart';
import 'package:routine_machine/Views/pages/FriendProfilePage.dart';
import 'package:routine_machine/Models/FriendStatus.dart';
import 'package:routine_machine/Models/UserData.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import './FollowTileInfo.dart';

class FollowingTile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String caption;
  final Color color;

  FollowingTile({this.firstName, this.lastName, this.caption, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          FollowTileInfo(
            firstName: this.firstName,
            lastName: this.lastName,
            caption: this.caption,
            color: this.color,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded),
            color: Colors.grey,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendProfilePage(
                    friendData: UserData(
                      profile: UserProfile(
                          alias: "Jack Zhao", username: "jackzhao98"),
                      data: [
                        WidgetData.widgetSample1,
                        WidgetData.widgetSample3
                      ],
                    ),
                    friendStatus: FriendStatus.follower,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
