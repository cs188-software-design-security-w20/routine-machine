import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;
import '../subviews/FollowRequestTileList.dart';
import '../components/TopBackBar.dart';
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
  Future<List<SampleFollowerRequestData>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = _searchForUser(searchController.text);
  }

  _SearchResultPageState(String searchText) {
    searchController = TextEditingController(text: searchText);
  }

  Future<List<SampleFollowerRequestData>> _searchForUser(String userName) {
    // TODO: update to call api wrapper
    print('search for user $userName...');
    return Future.delayed(new Duration(seconds: 2), () => sampleSearchResults);
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
                        _searchResults = _searchForUser(searchController.text);
                      });
                    },
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _searchResults,
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                Widget searchContent;
                if (snapshot.hasData) {
                  searchContent =
                      snapshot.data.isEmpty // default message if no results
                          ? Center(
                              child: Text(
                                'Sorry, the user "${searchController.text}" was not found',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : FollowRequestTileList(
                              followRequestList: snapshot.data,
                            );
                } else if (snapshot.hasError) {
                  searchContent = Text('Error loading username data');
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
                return Expanded(
                  child: searchContent,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
