import 'package:flutter/material.dart';
import './FollowTileInfo.dart';
import '../../constants/Palette.dart' as Palette;

class FollowerRequestTile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String userName;
  final String caption;
  final Color color;

  FollowerRequestTile(
      {this.firstName, this.lastName, this.userName, this.caption, this.color});

  _acceptRequest() {
    // TODO: properly implement this
    print('Accepted request!');
  }

  _rejectRequest() {
    // TODO: properly implement this
    print('Rejected request!');
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
          Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.check_circle_outline_rounded),
                  color: Palette.darkGreen,
                  iconSize: 32,
                  onPressed: _acceptRequest,
                ),
                IconButton(
                  icon: Icon(Icons.highlight_off_rounded),
                  color: Palette.red,
                  iconSize: 32,
                  onPressed: _rejectRequest,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
