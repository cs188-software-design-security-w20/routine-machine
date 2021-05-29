import 'package:flutter/material.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import './FollowTileInfo.dart';
import '../../constants/Palette.dart' as Palette;
import '../../Models/UserProfile.dart';
import '../../constants/Constants.dart' as Constants;

enum FollowStatus {
  none,
  pending,
  following,
}

class FollowRequestTile extends StatefulWidget {
  final APIWrapper api = APIWrapper();
  final String searchUserName;
  final UserProfile userProfile;
  final Color color;

  FollowRequestTile({this.searchUserName, this.userProfile, this.color});

  @override
  _FollowRequestTileState createState() => _FollowRequestTileState();
}

class _FollowRequestTileState extends State<FollowRequestTile> {
  Future<FollowStatus> _followStatus;

  @override
  void initState() {
    super.initState();
    _followStatus = _getFollowStatus();
  }

  Future<FollowStatus> _getFollowStatus() async {
    List<UserProfile> followingRequests =
        await widget.api.getPendingFollowingRequests();
    List<UserProfile> followingList = await widget.api.getFollowing();

    for (var request in followingRequests) {
      if (request.userID == widget.userProfile.userID) {
        return FollowStatus.pending;
      }
    }
    for (var followingUser in followingList) {
      if (followingUser.userID == widget.userProfile.userID) {
        return FollowStatus.following;
      }
    }
    return FollowStatus.none;
  }

  void _followUser() {
    setState(() {
      _followStatus = Future.value(FollowStatus.pending);
    });
    widget.api.sendFollowRequest(targetUserID: widget.userProfile.userID);
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
          FutureBuilder(
              future: _followStatus,
              builder:
                  (BuildContext context, AsyncSnapshot<FollowStatus> snapshot) {
                Widget statusWidget;
                if (snapshot.hasData) {
                  statusWidget = widget.searchUserName ==
                          widget.userProfile.username
                      ? Text(
                          "me",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "SF Pro Text",
                            fontSize: 16.0,
                          ),
                        )
                      : snapshot.data == FollowStatus.none
                          ? TextButton(
                              onPressed: _followUser,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text('Follow'),
                              ),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all(Palette.primary),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                            )
                          : snapshot.data == FollowStatus.pending
                              ? Text(
                                  'requested',
                                  style: Constants.kBodyLabelStyle,
                                )
                              : Text(
                                  'following',
                                  style: Constants.kBodyLabelStyle,
                                );
                } else if (snapshot.hasError) {
                  statusWidget = Text(
                    'error',
                    style: Constants.kBodyLabelStyle,
                  );
                } else {
                  statusWidget = Text('');
                }
                return statusWidget;
              }),
        ],
      ),
    );
  }
}
