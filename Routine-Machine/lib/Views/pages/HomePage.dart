import 'package:flutter/material.dart';
import '../../constants/Palette.dart' as Palette;
import '../components/BottomNavBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Page'),
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
