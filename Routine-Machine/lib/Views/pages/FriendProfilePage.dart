import 'package:flutter/material.dart';
import '../../constants/Palette.dart' as Palette;
import '../components/BottomNavBar.dart';

class FriendProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Friend Profile Page'),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.primary,
        child: Icon(Icons.add_rounded),
        onPressed: () => {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
