// import 'dart:html';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routine_machine/Views/components/MenuRow.dart';
import 'package:routine_machine/Views/components/custom_route.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import 'package:routine_machine/constants/Constants.dart';
import '../components/TopBackBar.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'package:routine_machine/constants/Palette.dart' as Palette;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:routine_machine/constants/Constants.dart' as Constants;

class AccountPage extends StatefulWidget {
  AccountPage({this.user});

  final User user;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  APIWrapper apiWrapper = new APIWrapper();
  String qrKey;
  Future<UserProfile> userProfile;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userProfile = _fetchUserData();
    apiWrapper.cse.getPrivateKey().then((value) => {
          qrKey = value.toString(),
          print("Private key generated: ${qrKey}"),
        });
  }

  Future<UserProfile> _fetchUserData() {
    print("fetching userdata for ${widget.user.uid}");
    return this.apiWrapper.queryUserProfile();
  }

  void showUserNameTakenAlert(BuildContext context, String username) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("oops"),
        content: Text("A user with username: ${username} already exists."),
        actions: [
          CupertinoButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  void activeChangeUsernamePage(BuildContext context) {
    // TODO: make this its own page file
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: TopBackBar(),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                Text(
                  "Change user name",
                  style: kTitle1Style,
                ),
                SizedBox(
                  height: 36,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "enter new username",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: Constants.kBodyLabelStyle,
                  controller: _usernameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[_\$a-zA-Z0-9]"))
                  ],
                ),
                SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          String username = _usernameController.text.trim();
                          apiWrapper
                              .isUsernameTaken(username: username)
                              .then((isTaken) => {
                                    if (isTaken)
                                      {
                                        print("username is taken"),
                                        showUserNameTakenAlert(
                                            context, username),
                                      }
                                    else
                                      {
                                        apiWrapper.setUserName(
                                            username: username),
                                        Navigator.pop(context),
                                      }
                                  });
                        },
                        child: Row(
                          children: [
                            Text(
                              'Save',
                              style: TextStyle(
                                color: Palette.primary,
                                fontFamily: 'SF Pro Text',
                                fontSize: 22,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Palette.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void activeChangeNamePage(BuildContext context) {
    // TODO: make this its own page file
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: TopBackBar(),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                Text(
                  "Change name",
                  style: kTitle1Style,
                ),
                SizedBox(
                  height: 36,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "first name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: Constants.kBodyLabelStyle,
                  controller: _firstNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[_\$a-zA-Z0-9]"))
                  ],
                ),
                SizedBox(
                  height: 36,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "last name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: Constants.kBodyLabelStyle,
                  controller: _lastNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[_\$a-zA-Z0-9]"))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          String firstName = _firstNameController.text.trim();
                          String lastName = _lastNameController.text.trim();
                          apiWrapper.setFirstName(firstName: firstName);
                          apiWrapper.setLastName(lastName: lastName);
                        },
                        child: Row(
                          children: [
                            Text(
                              'Save',
                              style: TextStyle(
                                color: Palette.primary,
                                fontFamily: 'SF Pro Text',
                                fontSize: 22,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Palette.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void activeNotificationPage(BuildContext context) {
    // TODO: make this its own page file
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
    // TODO: make this its own page file
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: TopBackBar(),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Credentials",
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
                    height: 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: FutureBuilder(
                        future: apiWrapper.cse.getPrivateKey(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            print(
                                "Has data: ${snapshot.data.toString().length}");
                            String displayThis = snapshot.data.toString();
                            return QrImage(
                              data: displayThis,
                              size: 0.7 * MediaQuery.of(context).size.width,
                            );
                          } else if (snapshot.hasError) {
                            return Text("You have an error: ${snapshot.error}");
                          } else {
                            return Text("Loading...");
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                      "This is your secret key, scan with your second device. Please do not show this code to anyone else."),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print('log out!');
      Navigator.pushReplacement(
        context,
        FadePageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print(e);
      Navigator.pushReplacement(
        context,
        FadePageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                FutureBuilder(
                    future: _fetchUserData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserProfile> snapshot) {
                      Widget accountContent;
                      if (snapshot.hasData) {
                        accountContent = Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Options",
                                  style: kLargeTitleStyle,
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            CircleAvatar(
                              backgroundColor: Palette.primary,
                              radius: 50,
                              child: Text(
                                snapshot.data.firstName[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 46.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SF Pro Text",
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Column(
                              children: [
                                Text(
                                  '${snapshot.data.firstName} ${snapshot.data.lastName}',
                                  style: kTitle1Style,
                                ),
                                Text(
                                  "@${snapshot.data.username}",
                                  style: kBigCaptionLabelStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                // children: [
                                MenuRow(
                                  icon: new Icon(
                                    SFSymbols.at,
                                    size: 32,
                                    color: Colors.grey,
                                  ),
                                  title: "Change username",
                                  action: () =>
                                      activeChangeUsernamePage(context),
                                ),
                                SizedBox(height: 16),
                                MenuRow(
                                  icon: new Icon(
                                    Icons.face,
                                    size: 26,
                                    color: Colors.green,
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
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        accountContent =
                            Text('Error loading user account data');
                      } else {
                        accountContent = Text('Loading user profile...');
                      }
                      return accountContent;
                    }),
                SizedBox(
                  height: 26,
                ),
                GestureDetector(
                  onTap: () => logOut(context),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        "Logout",
                        style: kBodyLabelStyle,
                      ),
                      SizedBox(width: 6),
                      new Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
