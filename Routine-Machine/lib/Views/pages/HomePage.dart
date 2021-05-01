import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import '../../constants/Palette.dart' as Palette;
import '../components/BottomNavBar.dart';
import 'LoginPage.dart';
import 'package:flutter/cupertino.dart';
import '../subviews/Dashboard.dart';

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

  final List<Widget> _children = [
    Container(
      color: Colors.white,
      child: Center(
        child: Text(
          "Home View",
          style: TextStyle(fontSize: 36),
        ),
      ),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text("Another View"),
      ),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text("3rd View"),
      ),
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
