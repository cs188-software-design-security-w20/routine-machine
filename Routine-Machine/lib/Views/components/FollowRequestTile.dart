import 'package:flutter/material.dart';
import './FollowTileInfo.dart';
import '../../constants/Palette.dart' as Palette;

class FollowRequestTile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String userName;
  final String caption;
  final Color color;

  FollowRequestTile(
      {this.firstName, this.lastName, this.userName, this.caption, this.color});

  void _followUser() {
    print('follow user @$userName!');
  }

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
          TextButton(
            onPressed: _followUser,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Follow'),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Palette.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
