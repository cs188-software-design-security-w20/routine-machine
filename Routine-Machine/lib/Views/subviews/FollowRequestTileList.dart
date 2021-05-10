import 'package:flutter/material.dart';
import '../components/FollowRequestTile.dart';

class FollowRequestTileList extends StatelessWidget {
  final List followRequestList;

  FollowRequestTileList({this.followRequestList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: followRequestList.length,
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        var user = followRequestList[index];
        return FollowRequestTile(
          firstName: user.firstName,
          lastName: user.lastName,
          userName: user.userName,
          caption: '@${user.userName}',
          color: user.color,
        );
      },
    );
  }
}
