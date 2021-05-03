import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;
import '../subviews/FollowRequestTileList.dart';
import '../../Models/SampleFollowerRequestData.dart';

final List<SampleFollowerRequestData> sampleSearchResults = [
  SampleFollowerRequestData(
    firstName: 'Richard',
    lastName: 'Tang',
    userName: 'rich_tang',
    color: Palette.blue,
  ),
  SampleFollowerRequestData(
    firstName: 'Joohyuk',
    lastName: 'Nam',
    userName: 'nam_dosan',
    color: Palette.yellow,
  ),
  SampleFollowerRequestData(
    firstName: 'Richard',
    lastName: 'Tang',
    userName: 'rich_tang',
    color: Palette.blue,
  ),
];

class SearchResultPage extends StatefulWidget {
  final String searchText;
  SearchResultPage({this.searchText});
  @override
  _SearchResultPageState createState() => _SearchResultPageState(searchText);
}

class _SearchResultPageState extends State<SearchResultPage> {
  TextEditingController searchController;
  List<SampleFollowerRequestData> _searchResults;

  _SearchResultPageState(String searchText) {
    searchController = TextEditingController(text: searchText);
    // Note: do NOT need to call setState() in constructor
    _searchResults = _searchForUser(searchText);
  }

  List<SampleFollowerRequestData> _searchForUser(String userName) {
    // TODO: search for results and return list
    // TODO: will have to convert this to use futures
    print('search for user $userName...');
    return sampleSearchResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.grey,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
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
                    onPressed: () async {
                      // TODO: update so search for people
                      setState(() {
                        _searchResults = _searchForUser(searchController.text);
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResults.isEmpty // default message if no results
                  ? Center(
                      child: Text(
                        'Sorry, the user "${searchController.text}" was not found',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : FollowRequestTileList(
                      followRequestList: _searchResults,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
