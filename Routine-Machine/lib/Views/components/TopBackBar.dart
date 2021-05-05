import 'package:flutter/material.dart';

class TopBackBar extends StatelessWidget implements PreferredSizeWidget {
  TopBackBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: Colors.grey,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
    );
  }

  @override
  final Size preferredSize; // default is 56.0
}
