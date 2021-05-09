import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import '../components/SmallWidgetView.dart';

class WidgetList extends StatelessWidget {
  // List<SampleWidgetData> widgetList;
  final List<WidgetData> widgetList;

  WidgetList({this.widgetList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        crossAxisSpacing: 20,
        mainAxisSpacing: 25,
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2,
        childAspectRatio: 3 / 4,
        children: widgetList
            .map(
              (widget) => SmallWidgetView(
                data: widget,
              ),
            )
            .toList(),
      ),
    );
  }
}
