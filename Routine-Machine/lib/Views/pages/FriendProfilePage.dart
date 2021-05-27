import 'package:flutter/material.dart';
import 'package:routine_machine/Views/subviews/FriendWidgetList.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import '../../constants/Constants.dart';
import '../components/TopBackBar.dart';
import '../../Models/UserProfile.dart';
import '../../Models/WidgetData.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;

enum FollowStatus {
  following,
  requested,
  none,
}

enum FollowerStatus {
  follower,
  none,
}

class FriendProfilePage extends StatefulWidget {
  final APIWrapper api = APIWrapper();
  final UserProfile friendProfile;
  final Color userColor;

  FriendProfilePage({this.friendProfile, this.userColor});

  @override
  _FriendProfilePageState createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  Future<List<WidgetData>> _friendWidgetDataList;
  Future<FollowStatus> _followStatus;
  Future<FollowerStatus> _followerStatus;

  @override
  void initState() {
    super.initState();
    _followStatus = _getFollowStatus();
    _followerStatus = _getFollowerStatus();
  }

  Future<FollowStatus> _getFollowStatus() async {
    setState(() {
      _friendWidgetDataList = Future.value([]);
    });
    var followingList = await widget.api.getFollowing();
    print('calculating follow status');
    for (var profile in followingList) {
      if (widget.friendProfile.userID == profile.userID) {
        setState(() {
          _friendWidgetDataList = _getFriendWidgetData();
        });
        return FollowStatus.following;
      }
    }
    var pendingFollowingList = await widget.api.getPendingFollowingRequests();
    for (var profile in pendingFollowingList) {
      if (widget.friendProfile.userID == profile.userID) {
        return FollowStatus.requested;
      }
    }
    return FollowStatus.none;
  }

  Future<FollowerStatus> _getFollowerStatus() async {
    var followerList = await widget.api.getFollowers();
    for (var profile in followerList) {
      if (widget.friendProfile.userID == profile.userID) {
        return FollowerStatus.follower;
      }
    }
    return FollowerStatus.none;
  }

  Future<List<WidgetData>> _getFriendWidgetData() {
    print('loading friend data');
    return widget.api
        .getFollowingHabitData(targetUserID: widget.friendProfile.userID);
  }

  void _followUser() {
    widget.api
        .sendFollowRequest(
      targetUserID: widget.friendProfile.userID,
    )
        .then((result) {
      print('sent follow request!');
      setState(() {
        _followStatus = Future.value(FollowStatus.requested);
      });
    }).catchError((error) {
      print("Error on followUser(): $error");
    });
  }

  void _unfollowUser() {
    widget.api
        .removeFollowing(targetUserID: widget.friendProfile.userID)
        .then((result) {
      print('successfully unfollowed user!');
      setState(() {
        _followStatus = Future.value(FollowStatus.none);
      });
    }).catchError((error) {
      print("Error on unfollowUser(): $error");
    });
  }

  void _removeFollower() {
    widget.api
        .removeFollower(targetUserID: widget.friendProfile.userID)
        .then((result) {
      print('follower succesfully removed!');
      _followerStatus = Future.value(FollowerStatus.none);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image here
              CircleAvatar(
                backgroundColor: widget.userColor,
                radius: 50,
                child: Text(
                  '${widget.friendProfile.firstName[0].toUpperCase()}',
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 47.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(
                      '${widget.friendProfile.firstName} ${widget.friendProfile.lastName}',
                      style: kTitle1Style,
                    ),
                    Text(
                      "@${widget.friendProfile.username}",
                      style: kCaptionLabelStyle,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: _followStatus,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<FollowStatus> snapshot,
                      ) {
                        Widget followButton;
                        if (snapshot.hasData) {
                          followButton = TextButton(
                            onPressed: snapshot.data == FollowStatus.following
                                ? _unfollowUser
                                : snapshot.data == FollowStatus.requested
                                    ? null
                                    : _followUser,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: snapshot.data == FollowStatus.following
                                  ? Text('Unfollow')
                                  : snapshot.data == FollowStatus.requested
                                      ? Text('requested')
                                      : Text('Follow'),
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
                          );
                        } else if (snapshot.hasError) {
                          followButton = Text(
                            'Error loading follow status',
                            style: Constants.kBodyLabelStyle,
                          );
                        } else {
                          followButton = Text('...');
                        }
                        return Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                          child: followButton,
                        );
                      }),
                  FutureBuilder(
                      future: _followerStatus,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<FollowerStatus> snapshot,
                      ) {
                        Widget followerButton;
                        if (snapshot.hasData) {
                          followerButton = snapshot.data ==
                                  FollowerStatus.follower
                              ? TextButton(
                                  onPressed: _removeFollower,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'Remove Follower',
                                      style: TextStyle(color: Palette.primary),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Palette.primary),
                                      ),
                                    ),
                                  ),
                                )
                              : TextButton(
                                  onPressed: null,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('not following you'),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Palette.grey),
                                      ),
                                    ),
                                  ),
                                );
                        } else if (snapshot.hasError) {
                          followerButton = Text(
                            'Error loading follower status',
                            style: Constants.kBodyLabelStyle,
                          );
                        } else {
                          followerButton = Text('...');
                        }
                        return Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                          child: followerButton,
                        );
                      }),
                ],
              ),
              FutureBuilder(
                  future: Future.wait([_followStatus, _friendWidgetDataList]),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    Widget friendDataContent;
                    if (snapshot.hasData) {
                      friendDataContent = snapshot.data[0] ==
                              FollowStatus.following
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                              child: FriendWidgetList(
                                data: snapshot.data[1],
                              ),
                            )
                          : Center(
                              child: Text(
                                'Unable to view habit data.\nSend a follow request to see their habits :)',
                                style: Constants.kBodyLabelStyle,
                                textAlign: TextAlign.center,
                              ),
                            );
                    } else if (snapshot.hasError) {
                      friendDataContent = Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: Constants.kBodyLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      friendDataContent = Center(
                        child: Text(
                          'Loading friend\'s data...',
                          style: Constants.kBodyLabelStyle,
                        ),
                      );
                    }
                    return friendDataContent;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
