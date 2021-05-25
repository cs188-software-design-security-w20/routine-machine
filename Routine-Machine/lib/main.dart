import 'package:flutter/material.dart';
import 'package:routine_machine/Views/pages/HomePage.dart';

import 'package:flutter/services.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import 'Views/pages/LoginPage.dart';
import 'Views/components/transition_route_observer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Views/pages/ScanQRPage.dart';
import 'Views/pages/SetUserInfoPage.dart';

// sample data to demo the check in list
final sampleCheckIns = <DateTime>[
  new DateTime.now(),
  new DateTime.utc(2021, 4, 20),
  new DateTime.utc(2020, 4, 30),
];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("firebase init");
  runApp(RoutineMachine());
}

class RoutineMachine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ScanQRPage(),
      home: LoginPage(),
      //sample login page
      title: 'Routine Machine',
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: Color(0xffB057F5),
        accentColor: Colors.white,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Color(0xffB057F5)),
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'SF Pro Rounded',
            fontSize: 15.0,
            // fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          button: TextStyle(
            fontFamily: 'SF Pro Rounded',
          ),
          caption: TextStyle(
            fontFamily: 'SF Pro Rounded',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Color(0xffB057F5),
          ),
          headline1: TextStyle(fontFamily: 'SF Pro Rounded'),
          headline2: TextStyle(fontFamily: 'SF Pro Rounded'),
          headline4: TextStyle(fontFamily: 'SF Pro Rounded'),
          headline5: TextStyle(fontFamily: 'SF Pro Rounded'),
          headline6: TextStyle(fontFamily: 'SF Pro Rounded'),
          subtitle1: TextStyle(fontFamily: 'SF Pro Rounded'),
          bodyText1: TextStyle(fontFamily: 'SF Pro Rounded'),
          bodyText2: TextStyle(fontFamily: 'SF Pro Rounded'),
          subtitle2: TextStyle(fontFamily: 'SF Pro Rounded'),
          overline: TextStyle(fontFamily: 'SF Pro Rounded'),
        ),
      ),
    );
  }
}
