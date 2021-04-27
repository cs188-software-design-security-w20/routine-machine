import 'package:flutter/material.dart';
import './constants/Palette.dart' as Palette;

class ProfileBarView extends StatelessWidget {
  // note: assuming that firstName and lastName are not empty strings
  final String firstName;
  final String lastName;

  ProfileBarView({this.firstName, this.lastName});

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
                  text: '${this.firstName} ${this.lastName[0]}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => {
              // TODO: navigate to profile page
              print('Clicked profile icon!')
            },
            child: CircleAvatar(
              backgroundColor: Palette.primary,
              radius: 26,
              child: Text(
                this.firstName[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 32.0,
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
