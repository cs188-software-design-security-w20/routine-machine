import 'package:flutter/material.dart';
import '../../constants/Palette.dart' as Palette;

class WidgetColorPicker extends StatelessWidget {
  final Function onSelectColor;
  final Palette.CardColors chosenColor;
  WidgetColorPicker({this.chosenColor, this.onSelectColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: Palette.CardColors.values
            .map(
              (color) => Radio(
                value: color,
                groupValue: this.chosenColor,
                activeColor: Palette.getColor(enumColor: color),
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Palette.getColor(enumColor: color)),
                fillColor: MaterialStateProperty.resolveWith(
                    (states) => Palette.getColor(enumColor: color)),
                onChanged: (value) {
                  onSelectColor(value);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
