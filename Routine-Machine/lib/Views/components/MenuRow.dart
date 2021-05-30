import 'package:flutter/material.dart';
import 'package:routine_machine/constants/Constants.dart';

class MenuRow extends StatefulWidget {
  MenuRow({@required this.icon, @required this.title, @required this.action});
  final Icon icon;
  final String title;
  final VoidCallback action;

  @override
  _MenuRowState createState() => _MenuRowState();
}

class _MenuRowState extends State<MenuRow> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      onTapDown: (TapDownDetails details) => {
        setState(() {
          tapped = true;
        }),
      },
      onTapUp: (TapUpDetails details) => {
        setState(() {
          tapped = false;
        }),
      },
      child: Opacity(
        opacity: tapped ? 0.4 : 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 52.0,
                    height: 52.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: widget.icon),
                SizedBox(width: 22),
                Container(
                  child: Text(
                    widget.title,
                    style: kTitle2RegularStyle,
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
