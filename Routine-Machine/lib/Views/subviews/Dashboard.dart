import 'package:flutter/material.dart';
import '../../Models/WidgetData.dart';

class Dashboard extends StatelessWidget {
  final WidgetData data;
  Dashboard(this.data);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            children: [
              Spacer(),
              SingleWidgetView(),
              Spacer(),
              SingleWidgetView(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleWidgetView extends StatelessWidget {
  const SingleWidgetView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Center(
        child: Column(
          children: [Text("Hello")],
        ),
      ),
    );
  }
}
