import 'package:flutter/material.dart';
import 'package:routine_machine/Views/pages/FriendProfilePage.dart';
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

                      // TODO: pass other data
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
