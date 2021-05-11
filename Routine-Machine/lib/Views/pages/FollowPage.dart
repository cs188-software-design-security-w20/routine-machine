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

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final searchController = TextEditingController();
  String _page = 'following';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  void _switchToFollowers() {
    if (_page != 'followers') {
      setState(() {
        _page = 'followers';
      });
    }
  }

  void _switchToFollowing() {
    if (_page != 'following') {
      setState(() {
        _page = 'following';
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
              : null, // for Jody's phone lmao - i have camera overlap
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _switchToFollowing,
                child: Text(
                  'Following',
                  style: _page == 'following'
                      ? Constants.kLargeTitleStyle
                      : Constants.kUnselectedTitleStyle,
                ),
              ),
              GestureDetector(
                onTap: _switchToFollowers,
                child: Text(
                  'Followers',
                  style: _page == 'followers'
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
            child: _page == 'following'
                ? FollowingTileList(
                    followingList: sampleFollowingList,
                  )
                : FollowerRequestTileList(
                    followerRequestList: sampleFollowerRequestList,
                  ),
          ),
        ],
      ),
    );
  }
}
