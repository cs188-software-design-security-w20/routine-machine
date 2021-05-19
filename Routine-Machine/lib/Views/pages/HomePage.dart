import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter/cupertino.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'LoginPage.dart';
import 'FollowPage.dart';
import 'MainDashboardPage.dart';
import 'AccountPage.dart';
import '../../constants/Palette.dart' as Palette;

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
    FollowPage(),
    AccountPage(),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.purple,
        child: const Icon(Icons.add_rounded, color: Colors.white),
        onPressed: () => {},
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
