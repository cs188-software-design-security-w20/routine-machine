import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/TopBackBar.dart';
import 'package:routine_machine/Views/components/custom_route.dart';
import './HomePage.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;

class SetUserInfoPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(style: Constants.kLargeTitleStyle, children: [
                  TextSpan(
                      text: 'Welcome\n',
                      style: TextStyle(color: Palette.primary)),
                  TextSpan(text: ' to Routine Machine'),
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Before we begin, let\'s set up your profile',
                  style: Constants.kSubtitleStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Username',
                  style: Constants.kTitle3Style,
                ),
              ),
              TextField(
                // username
                style: Constants.kBodyLabelStyle,
                controller: _usernameController,
                decoration: InputDecoration(hintText: 'Enter a username'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[_\$a-zA-Z0-9]"))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'First Name',
                  style: Constants.kTitle3Style,
                ),
              ),
              TextField(
                style: Constants.kBodyLabelStyle,
                controller: _firstNameController,
                decoration: InputDecoration(hintText: 'Enter your first name'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Last Name',
                  style: Constants.kTitle3Style,
                ),
              ),
              TextField(
                style: Constants.kBodyLabelStyle,
                controller: _lastNameController,
                decoration: InputDecoration(hintText: 'Enter your last name'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _setUserProfile(); // TODO: implement this
                        Navigator.pushReplacement(
                          context,
                          // TODO: pass stuff to home page here
                          FadePageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Begin',
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setUserProfile() {
    // TODO: call the create user profile stuff here
    String username = _usernameController.text.trim();
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    print('Username: $username, First Name: $firstName, Last Name: $lastName');
  }
}
