import 'package:flutter/material.dart';
import '../components/ProfileBarView.dart';
import '../components/SmallWidgetView.dart';

class HomeView extends StatelessWidget {
  List<Widget> sample = [
    SmallWidgetView(),
    SmallWidgetView(),
    SmallWidgetView(),
    SmallWidgetView(),
    SmallWidgetView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: false,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text("Dashboard"),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  width: 50,
                  padding: EdgeInsets.all(16),
                  child: sample[index],
                );
              },
              childCount: sample.length,
            ),
          ),
        ],
      )),
    );
  }
}
