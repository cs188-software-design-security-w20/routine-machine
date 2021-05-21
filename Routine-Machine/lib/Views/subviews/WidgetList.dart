import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import '../components/SmallWidgetView.dart';

class WidgetList extends StatelessWidget {
  final List<WidgetData> widgetList;
  final Function removeWidget;

  WidgetList({this.widgetList, this.removeWidget});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2,
        childAspectRatio: 0.73,
        children: widgetList
            .asMap()
            .entries
            .map(
              (widget) => SmallWidgetView(
                key: ObjectKey(widget),
                data: widget.value,
                index: widget.key,
                removeWidget: removeWidget,
              ),
            )
            .toList(),
      ),
    );
  }
}
