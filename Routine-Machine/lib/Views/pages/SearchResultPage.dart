import 'package:flutter/material.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;
import '../components/FollowRequestTile.dart';
import '../components/TopBackBar.dart';
import '../../Models/UserProfile.dart';

class SearchResultPage extends StatefulWidget {
  final String searchText;
  final APIWrapper api = APIWrapper();
  SearchResultPage({this.searchText});
  @override
  _SearchResultPageState createState() => _SearchResultPageState(searchText);
}

class _SearchResultPageState extends State<SearchResultPage> {
  TextEditingController searchController;
  Future<UserProfile> _searchResult;

  @override
  void initState() {
    super.initState();
    _searchResult = _searchForUser(searchController.text);
  }

  _SearchResultPageState(String searchText) {
    searchController = TextEditingController(text: searchText);
  }

  Future<UserProfile> _searchForUser(String username) {
    print('search for user $username...');
    return widget.api.getUserProfile(username: username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              'Search Results',
              style: Constants.kLargeTitleStyle,
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
                    onPressed: () {
                      setState(() {
                        _searchResult = _searchForUser(searchController.text);
                      });
                    },
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _searchResult,
              builder:
                  (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
                Widget searchContent;
                if (snapshot.hasData) {
                  searchContent = FollowRequestTile(
                    searchUserName: searchController.text,
                    userProfile: snapshot.data,
                    color: Palette.purple,
                  );
                } else if (snapshot.hasError) {
                  searchContent = Center(
                    child: Text(
                      'Sorry, user with username "${searchController.text}" was not found',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  searchContent = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Palette.primary),
                      ),
                      Text('Searching for friend...'),
                    ],
                  );
                }
                return searchContent;
              },
            ),
          ],
        ),
      ),
    );
  }
}
