import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter/cupertino.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import 'LoginPage.dart';
import 'FollowPage.dart';
import 'MainDashboardPage.dart';
import 'AccountPage.dart';
import '../../constants/Palette.dart' as Palette;

List<WidgetData> samples = [
  new WidgetData(
    title: "Drink Water",
    widgetType: "daily",
    color: 0xFF7CD0FF,
    createdTime: new DateTime.now(),
    modifiedTime: new DateTime.now(),
    currentPeriodCounts: 1,
    periodicalGoal: 6,
    checkins: [new DateTime.now()],
  ),
  WidgetData(
    title: "Exercise",
    widgetType: "weekly",
    color: 0xFFFFDF6B,
    createdTime: new DateTime.now(),
    modifiedTime: new DateTime.now(),
    currentPeriodCounts: 2,
    periodicalGoal: 4,
    checkins: [new DateTime.now(), new DateTime.now()],
  ),
  WidgetData(
    title: "Read the News",
    widgetType: "monthly",
    color: 0xFFFF93BA,
    createdTime: new DateTime.now(),
    modifiedTime: new DateTime.now(),
    currentPeriodCounts: 1,
    periodicalGoal: 20,
    checkins: [new DateTime.now()],
  ),
  WidgetData(
    title: "Exercise",
    widgetType: "weekly",
    color: 0xFFFFDF6B,
    createdTime: new DateTime.now(),
    modifiedTime: new DateTime.now(),
    currentPeriodCounts: 2,
    periodicalGoal: 4,
    checkins: [new DateTime.now(), new DateTime.now()],
  ),
];

class HomePage extends StatefulWidget {
  final User user;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<WidgetData>> _mainDashboardWidgetData;
  // Future<UserProfile> _mainUserProfileData;
  bool triedLogIn = false;
  String key = "";
  int _page = 0;
  PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    widget.storage.read(key: "key").then((value) => {
          this.key = value,
          print("HomePage user: ${widget.user}, ${this.key}"),
        });
    _mainDashboardWidgetData = _fetchWidgetData(widget.user);
  }

  Future<List<WidgetData>> _fetchWidgetData(User user) {
    // TODO: replace this with actual api wrapper call
    APIWrapper apiWrapper = new APIWrapper();
    apiWrapper.setUser(user);
    return apiWrapper.getHabitData();
  }

  void _removeWidget(int index) {
    setState(() {
      _mainDashboardWidgetData.then((widgetList) {
        widgetList.removeAt(index);
      });
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: new Icon(
          SFSymbols.square_grid_2x2,
          color: (_page == 0) ? Colors.black : Colors.grey,
        ),
        backgroundColor: Colors.white,
      ),
      BottomNavigationBarItem(
        icon: new Icon(
          SFSymbols.person_2,
          color: (_page == 1) ? Colors.black : Colors.grey,
        ),
        backgroundColor: Colors.white,
      ),
      BottomNavigationBarItem(
        icon: new Icon(
          SFSymbols.gear_alt,
          color: (_page == 2) ? Colors.black : Colors.grey,
        ),
        backgroundColor: Colors.white,
      ),
    ];
  }

  Widget loginPageBuilder() {
    return LoginPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildPageView() {
    return PageView(
      controller: _controller,
      onPageChanged: (index) {
        onPageChanged(index);
      },
      children: [
        MainDashboardPage(
          widgetList: _mainDashboardWidgetData,
          fetchWidgetData: _fetchWidgetData,
          removeWidget: _removeWidget,
        ),
        FollowPage(),
        AccountPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        items: buildBottomNavBarItems(),
        onTap: (index) {
          print(index);
          buttonTapped(index);
        },
      ),
      floatingActionButton: Visibility(
        visible: _page == 0,
        child: FloatingActionButton(
          backgroundColor: Palette.purple,
          child: const Icon(Icons.add_rounded, color: Colors.white),
          onPressed: () async {
            setState(() {
              _mainDashboardWidgetData.then((widgetList) {
                widgetList.add(
                  new WidgetData(
                    title: "New Habit",
                    widgetType: "daily",
                    color: 0xFFB057F5,
                    createdTime: new DateTime.now(),
                    modifiedTime: new DateTime.now(),
                    currentPeriodCounts: 0,
                    periodicalGoal: 1,
                    checkins: [],
                  ),
                );
              });
            });
          },
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void buttonTapped(int page) {
    this._controller.jumpToPage(page);
  }
}
