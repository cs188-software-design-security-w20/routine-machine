import 'package:flutter/material.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import '../../constants/Palette.dart' as Palette;
import '../pages/AccountPage.dart';

class ProfileBarView extends StatelessWidget {
  // note: assuming that firstName and lastName are not empty strings
  // final String firstName;
  // final String lastName;
  final UserProfile user;

  ProfileBarView({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: 'Hi,\n',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24.0,
              ),
              children: [
                TextSpan(
                  text: '${this.user.firstName}',
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountPage(
                    userProfile: this.user,
                  ),
                ),
              );
              print('Clicked profile icon!');
            },
            child: CircleAvatar(
              backgroundColor: Palette.primary,
              radius: 24,
              child: Text(
                this.user.firstName[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 27.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
