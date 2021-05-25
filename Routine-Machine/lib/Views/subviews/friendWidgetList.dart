import 'package:flutter/material.dart';
import '../../Models/WidgetData.dart';
import '../components/LongWidgetView.dart';
import '../../constants/Constants.dart' as Constants;

class FriendWidgetList extends StatelessWidget {
  final List<WidgetData> data;

  FriendWidgetList({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: data.isNotEmpty
            ? Wrap(
                runSpacing: 20,
                children: data
                    .map((widgetData) => LongWidgetView(widgetData))
                    .toList(),
              )
            : Center(
                child: Text(
                  'No habit data to show!',
                  style: Constants.kBodyLabelStyle,
                ),
              ));
  }
}
