import 'package:flutter/material.dart';
import '../../Models/WidgetData.dart';
import '../components/LongWidgetView.dart';

class FriendWidgetList extends StatelessWidget {
  final List<WidgetData> data;

  FriendWidgetList({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 20,
        children: data.map((widgetData) => LongWidgetView(widgetData)).toList(),
      ),
    );
  }
}
