import 'package:flutter/material.dart';
import '../components/TopBackBar.dart';
import '../../Models/FriendStatus.dart';

class FriendProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  FriendStatus status;
  // TODO: inject more data into this widget

  FriendProfilePage({this.firstName, this.lastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      body: Center(
        child: Text('${this.firstName} ${this.lastName}\'s Profile Page'),
      ),
    );
  }
}
