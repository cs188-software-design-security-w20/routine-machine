import 'package:flutter/material.dart';
import '../components/FollowRequestTile.dart';
import '../../constants/Palette.dart' as Palette;

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
        return FollowRequestTile(
          userProfile: followRequestList[index],
          color: Palette.purple,
        );
      },
    );
  }
}
