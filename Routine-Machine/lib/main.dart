import 'package:flutter/material.dart';
import 'package:routine_machine/Views/pages/HomePage.dart';

void main() => runApp(RoutineMachine());

class RoutineMachine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "SF Pro Rounded"),
      title: "Routine Machine",
      home: HomePage(),
    );
  }
}

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
