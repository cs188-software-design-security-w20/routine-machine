import 'package:flutter/material.dart';
import 'package:routine_machine/Views/components/MenuRow.dart';
import '../components/TopBackBar.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'package:routine_machine/constants/Palette.dart' as Palette;

class AccountPage extends StatelessWidget {
  final UserProfile userProfile;

  AccountPage({this.userProfile});

  void activeChangeNamePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: TopBackBar(),
          body: Text("Change name"),
        ),
      ),
    );
  }

  void activeNotificationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: TopBackBar(),
          body: Text("Notification"),
        ),
      ),
    );
  }

  void activeQRCodePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: TopBackBar(),
          body: Text("QR"),
        ),
      ),
    );
  }

  void logOut() {
    print("Log out tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBackBar(),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Options",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SF Pro Text",
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  backgroundColor: Palette.primary,
                  radius: 50,
                  child: Text(
                    this.userProfile.firstName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 46.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: "SF Pro Text",
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Column(
                  children: [
                    MenuRow(
                      icon: new Icon(
                        Icons.face,
                        size: 32,
                      ),
                      title: "Change Name",
                      action: () => activeChangeNamePage(context),
                    ),
                    SizedBox(height: 16),
                    MenuRow(
                      icon: new Icon(
                        SFSymbols.qrcode,
                        size: 32,
                      ),
                      title: "View credentials",
                      action: () => activeQRCodePage(context),
                    ),
                    SizedBox(height: 16),
                    MenuRow(
                      icon: new Icon(
                        SFSymbols.alarm,
                        size: 32,
                      ),
                      title: "Notifications",
                      action: () => activeNotificationPage(context),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => logOut(),
                      child: Row(
                        children: [
                          Spacer(),
                          Text("Logout"),
                          SizedBox(width: 6),
                          new Icon(Icons.exit_to_app),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
