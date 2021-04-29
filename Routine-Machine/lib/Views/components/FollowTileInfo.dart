import 'package:flutter/material.dart';

class FollowTileInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String caption;
  final Color color;
  FollowTileInfo({
    this.firstName,
    this.lastName,
    this.caption,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: CircleAvatar(
                backgroundColor: this.color,
                foregroundColor: Colors.white,
                radius: 26,
                child: Text(
                  this.firstName[0],
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
              child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: '${this.firstName} ${this.lastName}\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  children: [
                    TextSpan(
                      text: this.caption,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
