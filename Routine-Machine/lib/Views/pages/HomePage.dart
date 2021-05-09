import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter/cupertino.dart';
import 'package:routine_machine/Models/FriendStatus.dart';
import 'package:routine_machine/Models/UserData.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/Views/pages/FriendProfilePage.dart';
import 'package:routine_machine/Views/subviews/friendWidgetList.dart';
import 'LoginPage.dart';
import 'FollowPage.dart';
import 'MainDashboardPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool triedLogIn = false;
  PageController _controller = PageController(
    initialPage: 0,
  );
  int _page = 0;

  List<Widget> _children = [
    MainDashboardPage(),
    FriendProfilePage(
      friendData: UserData(
        profile: UserProfile(userName: "Jack Zhao", userId: "jackzhao98"),
        data: [WidgetData.widgetSample1, WidgetData.widgetSample3],
      ),
      friendStatus: FriendStatus.follower,
    ),
    FriendWidgetList(
      data: [WidgetData.widgetSample1, WidgetData.widgetSample3],
    ),
  ];

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
      children: this._children,
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
