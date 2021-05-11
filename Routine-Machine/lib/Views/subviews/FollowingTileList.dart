import 'package:flutter/material.dart';
import '../components/FollowingTile.dart';
import '../../constants/Palette.dart' as Palette;

final List colors = [
  Palette.pink,
  Palette.yellow,
  Palette.orange,
  Palette.green,
  Palette.blue,
  Palette.purple,
];

class FollowingTileList extends StatelessWidget {
  final List followingList;

  FollowingTileList({this.followingList});

  @override
  Widget build(BuildContext context) {
    return this.followingList.isEmpty
        ? Text(
            'Search for people to see their habits :)') // default message if not following anyone
        : ListView.separated(
            itemCount: followingList.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (context, index) {
              return FollowingTile(
                followingProfile: followingList[index],
                color: colors[index % colors.length],
              );
            },
          );
  }
}
