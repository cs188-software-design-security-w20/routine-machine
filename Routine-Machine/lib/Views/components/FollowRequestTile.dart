import 'package:flutter/material.dart';
import './FollowTileInfo.dart';
import '../../constants/Palette.dart' as Palette;
import '../../Models/UserProfile.dart';

enum FollowStatus {
  pending,
  following,
}

class FollowRequestTile extends StatefulWidget {
  final UserProfile userProfile;
  final Color color;

  FollowRequestTile({this.userProfile, this.color});

  @override
  _FollowRequestTileState createState() => _FollowRequestTileState();
}

class _FollowRequestTileState extends State<FollowRequestTile> {
  FollowStatus _followStatus =
      FollowStatus.pending; // TODO: initialize with actual following status

  void _followUser() {
    // TODO: call API Wrapper to send following request
    setState(() {
      _followStatus = FollowStatus.following;
    });
    print('follow user @${this.widget.userProfile.username}!');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          FollowTileInfo(
            firstName: this.widget.userProfile.firstName,
            lastName: this.widget.userProfile.lastName,
            caption: '@${this.widget.userProfile.username}',
            color: this.widget.color,
          ),
          _followStatus == FollowStatus.pending
              ? TextButton(
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
                )
              : Text('request sent'),
        ],
      ),
    );
  }
}
