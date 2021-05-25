import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'RingProgressBar.dart';
import '../../constants/Constants.dart' as Constants;
import '../pages/HabitDetailPage.dart';

class SmallWidgetView extends StatefulWidget {
  WidgetData data;
  final int index;
  final Function removeWidget;
  final Function updateWidget;

  SmallWidgetView({
    Key key,
    this.data,
    this.index,
    this.removeWidget,
    this.updateWidget,
  }) : super(key: key);

  @override
  _SmallWidgetViewState createState() => _SmallWidgetViewState();
}

class _SmallWidgetViewState extends State<SmallWidgetView> {
  // WidgetData data;

  @override
  void initState() {
    super.initState();
    // data = widget.data;
  }

  void _incrementCount() {
    setState(() {
      widget.data.currentPeriodCounts += 1;
      widget.data.checkins.add(DateTime.now());
      // widget.updateWidget(widget.data, widget.index);
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
          data: widget.data,
          index: widget.index,
          removeWidget: widget.removeWidget,
        ),
      ),
    );
    setState(() {
      widget.data = updatedData;
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
                widget.data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Constants.kTitle3Style,
              ),
            ),
            GestureDetector(
              onTap: _incrementCount,
              child: RingProgressBar(
                currentCount: widget.data.currentPeriodCounts,
                goalCount: widget.data.periodicalGoal,
                habitType: widget.data.widgetType,
                color: Color(widget.data.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
