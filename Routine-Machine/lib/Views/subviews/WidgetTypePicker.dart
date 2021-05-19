import 'package:flutter/material.dart';
import '../../Models/WidgetType.dart';
import '../components/WidgetTypeButton.dart';

class WidgetTypePicker extends StatelessWidget {
  final String type;
  final Function onSelectType;

  WidgetTypePicker({this.type, this.onSelectType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: WidgetType.values
            .map(
              (type) => GestureDetector(
                onTap: () {
                  onSelectType(type
                      .toString()
                      .split('.')
                      .last); // TODO: replace widget type with enum value instead so we don't need this tacky fix
                },
                child: WidgetTypeButton(
                  type: type.toString().split('.').last,
                  selected: this.type == type.toString().split('.').last,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
