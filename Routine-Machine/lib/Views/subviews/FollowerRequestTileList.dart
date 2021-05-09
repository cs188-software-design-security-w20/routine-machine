import 'package:flutter/material.dart';
import '../components/FollowerRequestTile.dart';

class FollowerRequestTileList extends StatelessWidget {
  final List followerRequestList;

  FollowerRequestTileList({this.followerRequestList});

  @override
  Widget build(BuildContext context) {
    return this.followerRequestList.isEmpty
        ? Text(
            'You currently have no pending requests :)') // default message if not following anyone
        : ListView.separated(
            itemCount: followerRequestList.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (context, index) {
              var user = followerRequestList[index];
              String requestCaption = 'requests to follow you';
              return FollowerRequestTile(
                firstName: user.firstName,
                lastName: user.lastName,
                userName: user.alias,
                caption: requestCaption,
                color: user.color,
              );
            },
          );
  }
}
