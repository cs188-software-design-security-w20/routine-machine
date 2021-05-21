import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'RingProgressBar.dart';
import '../../constants/Constants.dart' as Constants;
import '../pages/HabitDetailPage.dart';

class SmallWidgetView extends StatefulWidget {
  final WidgetData data;
  final int index;
  final Function removeWidget;

  SmallWidgetView({
    Key key,
    this.data,
    this.index,
    this.removeWidget,
  }) : super(key: key);

  @override
  _SmallWidgetViewState createState() => _SmallWidgetViewState();
}

class _SmallWidgetViewState extends State<SmallWidgetView> {
  WidgetData data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  void _incrementCount() {
    setState(() {
      data.currentPeriodCounts += 1;
      data.checkins.add(DateTime.now());
    });
  }

  void _buildDetailPageAndAwaitCount(BuildContext context) async {
    // when the detail page is popped
    // it will return the updated value of count
    // then we will set the state to match this value
    final WidgetData updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitDetailPage(
          data: data,
          index: widget.index,
          removeWidget: widget.removeWidget,
        ),
      ),
    );
    setState(() {
      data = updatedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _buildDetailPageAndAwaitCount(context),
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: Constants.kCardDecorationStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Constants.kTitle3Style,
              ),
            ),
            GestureDetector(
              onTap: _incrementCount,
              child: RingProgressBar(
                currentCount: data.currentPeriodCounts,
                goalCount: data.periodicalGoal,
                habitType: data.widgetType,
                color: Color(data.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
