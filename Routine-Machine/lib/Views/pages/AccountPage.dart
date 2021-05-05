import 'package:flutter/material.dart';
import '../components/TopBackBar.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      body: Container(
        child: Center(
          child: Text('Account Page'),
        ),
      ),
    );
  }
}
