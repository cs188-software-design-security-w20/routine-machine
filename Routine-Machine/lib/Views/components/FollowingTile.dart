import 'package:flutter/material.dart';
import 'package:routine_machine/Views/pages/FriendProfilePage.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import './FollowTileInfo.dart';

class FollowingTile extends StatelessWidget {
  final UserProfile followingProfile;
  final Color color;

  FollowingTile({this.followingProfile, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          FollowTileInfo(
            firstName: this.followingProfile.firstName,
            lastName: this.followingProfile.lastName,
            caption: '@${this.followingProfile.username}',
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
                    friendProfile: followingProfile,
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
