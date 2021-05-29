import 'package:flutter/material.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import 'SearchResultPage.dart';
import '../../constants/Constants.dart' as Constants;
import '../subviews/FollowingTileList.dart';
import '../subviews/FollowerTileList.dart';
import '../../Models/UserProfile.dart';

enum FollowPageType {
  followers,
  following,
}

class FollowPage extends StatefulWidget {
  final APIWrapper api = APIWrapper();
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final searchController = TextEditingController();
  FollowPageType _page = FollowPageType.following;
  Future<List<UserProfile>> _followingList;
  Future<List<UserProfile>> _followerRequestList;
  Future<List<UserProfile>> _followerList;

  @override
  void initState() {
    super.initState();
    _followingList = _getFollowingList();
    _followerRequestList = _getFollowerRequestList();
    _followerList = _getFollowerList();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  Future<List<UserProfile>> _getFollowingList() {
    return widget.api.getFollowing();
  }

  Future<List<UserProfile>> _getFollowerRequestList() {
    return widget.api.getPendingFollowerRequests();
  }

  Future<List<UserProfile>> _getFollowerList() {
    return widget.api.getFollowers();
  }

  void _refreshFollowerList() {
    setState(() {
      _followerList = _getFollowerList();
      _followerRequestList = _getFollowerRequestList();
    });
    print('Refresh follower list!');
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
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
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
                onSubmitted: (_) async {
                  await _searchForUser(context, searchController.text);
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Future.wait(
                    [_followingList, _followerRequestList, _followerList]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
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
                                _followerRequestList =
                                    _getFollowerRequestList();
                                _followerList = _getFollowerList();
                              });
                            },
                            child: FollowerTileList(
                              followerRequestList: snapshot.data[1],
                              followerList: snapshot.data[2],
                              refreshFollowerList: _refreshFollowerList,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
