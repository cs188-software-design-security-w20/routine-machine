import 'package:flutter/material.dart';
import 'package:routine_machine/FollowingTile.dart';
import 'package:timeago/timeago.dart' as timeago;

class FollowingTileList extends StatelessWidget {
  final List followingList;

  FollowingTileList({this.followingList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: followingList.length,
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        var user = followingList[index];
        String lastRoutineCheckIn =
            '${user.routineName} ${timeago.format(user.lastCheckIn)}';
        return FollowingTile(
          firstName: user.firstName,
          lastName: user.lastName,
          caption: lastRoutineCheckIn,
          color: user.color,
        );
      },
    );
  }
}
