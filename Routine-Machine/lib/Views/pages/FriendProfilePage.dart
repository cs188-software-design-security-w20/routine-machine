import 'package:flutter/material.dart';
import '../../constants/Constants.dart' as Constants;
import '../components/BottomNavBar.dart';

class FriendProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  // TODO: inject more data into this widget

  FriendProfilePage({this.firstName, this.lastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.white, // will need to fix this to match body color
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.grey,
        ),
      ),
      body: Center(
        child: Text('${this.firstName} ${this.lastName}\'s Profile Page'),
      ),
    );
  }
}
