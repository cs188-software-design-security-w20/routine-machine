import 'package:flutter/material.dart';

import 'Models/SampleFollowTileData.dart';
import 'constants/Palette.dart' as Palette;

import 'Views/components/RingProgressBar.dart';
import 'Views/components/BottomNavBar.dart';
import 'Views/components/ProfileBarView.dart';
import 'Views/subviews/CheckInList.dart';
import 'Views/subviews/FollowingTileList.dart';

<<<<<<< Updated upstream
// sample data to demo the check in list
final sampleCheckIns = <DateTime>[
  new DateTime.now(),
  new DateTime.utc(2021, 4, 20),
  new DateTime.utc(2020, 4, 30),
];

final List<SampleFollowTileData> sampleFollowingList = [
  SampleFollowTileData(
    firstName: 'Spencer',
    lastName: 'Jin',
    routineName: 'Workout',
    lastCheckIn: new DateTime.now(),
    color: Palette.pink,
  ),
  SampleFollowTileData(
    firstName: 'Lee',
    lastName: 'Jieun',
    routineName: 'Practice singing',
    lastCheckIn: new DateTime.now().subtract(new Duration(minutes: 15)),
    color: Palette.purple,
  ),
  SampleFollowTileData(
    firstName: 'Erika',
    lastName: 'Shen',
    routineName: 'Hike',
    lastCheckIn: new DateTime.now().subtract(new Duration(days: 1)),
    color: Palette.blue,
  ),
];
void main() => runApp(MyApp());
=======
import 'package:flutter/services.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'transition_route_observer.dart';

//sample demo for login page
void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  runApp(MyApp());
}
>>>>>>> Stashed changes

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      title: 'Routine Machine',
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ProfileBarView(firstName: 'Jody', lastName: 'Lin'),
              CheckInList(
                checkIns: sampleCheckIns,
                color: 0xFFC960FF,
              ),
              RingProgressBar(
                currentCount: 17,
                goalCount: 20,
                habitType: 'monthly',
                color: 0xFFC960FF,
              ),
              FollowingTileList(followingList: sampleFollowingList),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.primary,
          child: Icon(Icons.add_rounded),
          onPressed: () => {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
=======
      title: 'Login Page',
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
      home: LoginScreen(),
      // navigatorObservers: [TransitionRouteObserver()],
      // initialRoute: LoginScreen.routeName,
      // routes: {
      //   LoginScreen.routeName: (context) => LoginScreen(),
      //   DashboardScreen.routeName: (context) => DashboardScreen(),
      // },
    );
  }
}

// // sample data to demo the check in list
// final sampleCheckIns = <DateTime>[
//   new DateTime.now(),
//   new DateTime.utc(2021, 4, 20),
//   new DateTime.utc(2020, 4, 30),
// ];
// void main() => runApp(RoutineMachine());

// class RoutineMachine extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(fontFamily: "SF Pro Rounded"),
//       title: "Routine Machine",
//       home: HomePage(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(fontFamily: "SF Pro Rounded"),
//       title: 'Routine Machine',
//       home: Scaffold(
//         body: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               ProfileBarView(firstName: 'Jody', lastName: 'Lin'),
//               CheckInList(
//                 checkIns: sampleCheckIns,
//                 color: 0xFFC960FF,
//               ),
//               Row(
//                 children: [
//                   Spacer(),
//                   SmallWidgetView(),
//                   Spacer(),
//                   SmallWidgetView(),
//                   Spacer(),
//                 ],
//               ),
//               // FollowingTileList(followingList: sampleFollowingList),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavBar(),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Palette.primary,
//           child: Icon(Icons.add_rounded),
//           onPressed: () => {},
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }
// }
>>>>>>> Stashed changes
