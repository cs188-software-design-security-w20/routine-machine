import 'package:flutter/material.dart';
import '../../constants/Palette.dart' as Palette;

class WidgetTypeButton extends StatelessWidget {
  final String type;
  final bool selected;
  WidgetTypeButton({
    this.type,
    this.selected,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: selected ? Palette.primary : Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Text(
        type,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontFamily: 'SF Pro Text',
          fontSize: 16.0,
        ),
      ),
    );
  }
}
