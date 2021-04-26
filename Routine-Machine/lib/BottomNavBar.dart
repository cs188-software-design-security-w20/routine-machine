import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              color: Colors.grey,
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.people_outline_rounded),
              color: Colors.grey,
              onPressed: () => {},
            ),
            IconButton(
              // empty placeholder so FAB can sit on top
              icon: Icon(null),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              color: Colors.grey,
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.settings_outlined),
              color: Colors.grey,
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
    // return BottomNavigationBar(
    //   showSelectedLabels: false,
    //   showUnselectedLabels: false,
    //   unselectedItemColor: Colors.grey,
    //   selectedItemColor: Colors.blue,
    //   elevation: 0.0,
    //   type: BottomNavigationBarType.fixed,
    //   items: const [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home_outlined),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.people_outline_rounded),
    //       label: 'Follow',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(null),
    //       label: 'Empty',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.notifications_none_outlined),
    //       label: 'Notifications',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.settings_outlined),
    //       label: 'Settings',
    //     ),
    //   ],
    // );
  }
}
