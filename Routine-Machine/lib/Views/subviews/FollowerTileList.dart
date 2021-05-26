import 'package:flutter/material.dart';
import '../../constants/Palette.dart' as Palette;
import '../components/FollowerRequestTile.dart';
import '../components/FollowerTile.dart';
import 'package:flutter/cupertino.dart';

class FollowerTileList extends StatelessWidget {
  final List followerRequestList;
  final List followerList;
  final Function refreshFollowerList;

  List<dynamic> combinedFollowerList;

  FollowerTileList(
      {this.followerRequestList, this.followerList, this.refreshFollowerList}) {
    combinedFollowerList = followerRequestList + followerList;
  }

  @override
  Widget build(BuildContext context) {
    return this.combinedFollowerList.isEmpty
        ? Text(
            'You currently have no pending requests or followers:)') // default message if not following anyone
        : ListView.separated(
            itemCount: combinedFollowerList.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (context, index) {
              var userProfile = combinedFollowerList[index];
              return index < followerRequestList.length
                  ? FollowerRequestTile(
                      userProfile: userProfile,
                      color: Palette.yellow,
                      refreshFollowerList: refreshFollowerList,
                    )
                  : FollowerTile(
                      followerProfile: userProfile,
                      color: Palette.blue,
                    );
            },
          );
  }
}
