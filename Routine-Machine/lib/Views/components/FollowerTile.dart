import 'package:flutter/material.dart';
import 'package:routine_machine/Views/pages/FriendProfilePage.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import './FollowTileInfo.dart';

class FollowerTile extends StatelessWidget {
  final UserProfile followerProfile;
  final Color color;

  FollowerTile({this.followerProfile, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          FollowTileInfo(
            firstName: this.followerProfile.firstName,
            lastName: this.followerProfile.lastName,
            caption: '@${this.followerProfile.username} follows you',
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
                    friendProfile: followerProfile,
                    userColor: this.color,
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
