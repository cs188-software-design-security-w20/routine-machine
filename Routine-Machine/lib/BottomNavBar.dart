import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: define the onPressed functions to navigate to each page
    return BottomAppBar(
      elevation: 0,
      child: Container(
        color: Theme.of(context)
            .scaffoldBackgroundColor, // light grey background of app
        height: 60,
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
  }
}
