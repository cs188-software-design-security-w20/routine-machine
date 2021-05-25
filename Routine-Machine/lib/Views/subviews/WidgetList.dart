import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import '../components/SmallWidgetView.dart';
import '../../constants/Constants.dart' as Constants;

class WidgetList extends StatelessWidget {
  final List<WidgetData> widgetList;
  final Function removeWidget;
  final Function updateWidget;

  WidgetList({
    this.widgetList,
    this.removeWidget,
    this.updateWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widgetList.isNotEmpty
          ? GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 4
                      : 2,
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
                      updateWidget: updateWidget,
                    ),
                  )
                  .toList(),
            )
          : Center(
              child: Text(
                'Click the + to start\n tracking your habits :)',
                style: Constants.kUnselectedTitleStyle,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
