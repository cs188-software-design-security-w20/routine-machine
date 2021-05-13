import 'package:flutter/material.dart';
import 'dart:io';

import 'SearchResultPage.dart';
import '../../constants/Palette.dart' as Palette;
import '../../constants/Constants.dart' as Constants;
import '../subviews/FollowingTileList.dart';
import '../subviews/FollowerRequestTileList.dart';
import '../../Models/SampleFollowerRequestData.dart';
import '../../Models/UserProfile.dart';

final List<UserProfile> sampleFollowingList = [
  UserProfile(
    firstName: 'Spencer',
    lastName: 'Jin',
    username: 'sj_sj_sj',
  ),
  UserProfile(
    firstName: 'Erika',
    lastName: 'Shen',
    username: 'eggy',
  ),
  UserProfile(
    firstName: 'Jody',
    lastName: 'Lin',
    username: 'jowody',
  ),
  UserProfile(
    firstName: 'Spencer',
    lastName: 'Jin',
    username: 'sj_sj_sj',
  ),
  UserProfile(
    firstName: 'Erika',
    lastName: 'Shen',
    username: 'eggy',
  ),
  UserProfile(
    firstName: 'Jody',
    lastName: 'Lin',
    username: 'jowody',
  ),
  UserProfile(
    firstName: 'Spencer',
    lastName: 'Jin',
    username: 'sj_sj_sj',
  ),
  UserProfile(
    firstName: 'Erika',
    lastName: 'Shen',
    username: 'eggy',
  ),
  UserProfile(
    firstName: 'Jody',
    lastName: 'Lin',
    username: 'jowody',
  )
];

final List<SampleFollowerRequestData> sampleFollowerRequestList = [
  SampleFollowerRequestData(
    firstName: 'Carina',
    lastName: 'Xiong',
    userName: 'carina_x',
    color: Palette.blue,
  ),
  SampleFollowerRequestData(
    firstName: 'Jack',
    lastName: 'Zhao',
    userName: 'jjack_zz',
    color: Palette.pink,
  ),
  SampleFollowerRequestData(
    firstName: 'Jody',
    lastName: 'Lin',
    userName: 'jowody',
    color: Palette.yellow,
  ),
];

enum FollowPageType {
  followers,
  following,
}

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final searchController = TextEditingController();
  FollowPageType _page = FollowPageType.following;
  Future<List<dynamic>> _followingList;
  Future<List<dynamic>> _followerRequestList;

  @override
  void initState() {
    super.initState();
    _followingList = _getFollowingList();
    _followerRequestList = _getFollowerRequestList();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> _getFollowingList() {
    return Future.delayed(new Duration(seconds: 2), () => sampleFollowingList);
  }

  Future<List<dynamic>> _getFollowerRequestList() {
    return Future.delayed(
        new Duration(seconds: 2), () => sampleFollowerRequestList);
  }

  void _switchToFollowers() {
    if (_page != FollowPageType.followers) {
      setState(() {
        _page = FollowPageType.followers;
      });
    }
  }

  void _switchToFollowing() {
    if (_page != FollowPageType.following) {
      setState(() {
        _page = FollowPageType.following;
      });
    }
  }

  void _searchForUser(BuildContext context, String userName) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(searchText: userName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Platform.isAndroid
              ? SizedBox(height: 36)
              : SizedBox(
                  height: 0,
                ), // for Jody's phone lmao - i have camera overlap
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _switchToFollowing,
                child: Text(
                  'Following',
                  style: _page == FollowPageType.following
                      ? Constants.kLargeTitleStyle
                      : Constants.kUnselectedTitleStyle,
                ),
              ),
              GestureDetector(
                onTap: _switchToFollowers,
                child: Text(
                  'Followers',
                  style: _page == FollowPageType.followers
                      ? Constants.kLargeTitleStyle
                      : Constants.kUnselectedTitleStyle,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Search for friends...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () async {
                    // TODO: update so search for people
                    print('search for ${searchController.text}!');
                    _searchForUser(context, searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: Future.wait([_followingList, _followerRequestList]),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              Widget followContent;
              if (snapshot.hasData) {
                followContent = _page == FollowPageType.following
                    ? RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            _followingList = _getFollowingList();
                          });
                        },
                        child: FollowingTileList(
                          followingList: snapshot.data[0],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            _followerRequestList = _getFollowerRequestList();
                          });
                        },
                        child: FollowerRequestTileList(
                          followerRequestList: snapshot.data[1],
                        ),
                      );
              } else if (snapshot.hasError) {
                followContent = Center(
                  child: Text('Error loading follow data'),
                );
              } else {
                followContent = Center(
                  child: Text('loading follow data...'),
                );
              }
              return followContent;
            },
          )),
        ],
      ),
    );
  }
}
