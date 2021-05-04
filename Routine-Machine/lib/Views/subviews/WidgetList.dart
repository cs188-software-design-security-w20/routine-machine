import 'package:flutter/material.dart';
import '../components/SmallWidgetView.dart';
import '../../Models/SampleWidgetData.dart';

class WidgetList extends StatelessWidget {
  List<SampleWidgetData> widgetList;

  WidgetList({this.widgetList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2,
        childAspectRatio: 4 / 5,
        children: widgetList
            .map(
              (widget) => SmallWidgetView(
                routineName: widget.routineName,
                widgetType: widget.widgetType,
                count: widget.count,
                goal: widget.goal,
                checkIns: widget.checkIns,
                color: widget.color,
              ),
            )
            .toList(),
      ),
    );
  }
}
