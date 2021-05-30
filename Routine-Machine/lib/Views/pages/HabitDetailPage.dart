import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routine_machine/Views/subviews/WidgetColorPicker.dart';
import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;
import '../components/RingProgressBar.dart';
import '../components/TopBackBar.dart';
import '../subviews/CheckInList.dart';
import '../subviews/WidgetTypePicker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:routine_machine/Models/WidgetType.dart';
import 'package:routine_machine/Models/WidgetData.dart';

class HabitDetailPage extends StatefulWidget {
  WidgetData data;
  final int index;
  final Function removeWidget;
  HabitDetailPage({this.data, this.index, this.removeWidget});

  @override
  _HabitDetailPageState createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  TextEditingController _habitNameController;
  final TextEditingController _goalCountController = TextEditingController();
  Palette.CardColors color = Palette.CardColors.purple;
  WidgetType type = WidgetType.daily;

  WidgetData data;
  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.data;
      _habitNameController = TextEditingController(text: data.title);
    });
  }

  void _incrementCount() {
    setState(() {
      data.currentPeriodCounts += 1;
      data.checkins.add(DateTime.now());
    });
  }

  void _decrementCount() {
    setState(() {
      if (data.currentPeriodCounts > 0 && data.checkins.isNotEmpty) {
        data.currentPeriodCounts -= 1;
        data.checkins.removeLast();
      }
    });
  }

  void _setGoalCount(String goal) {
    setState(() {
      // goal is already validated to be a number in the text field
      data.periodicalGoal = int.parse(goal);
    });
  }

  void _setColor(Palette.CardColors color) {
    setState(() {
      data.color = Palette.getColor(enumColor: color).value;
    });
  }

  void _setWidgetType(String type) {
    setState(() {
      data.widgetType = type;
    });
  }

  Palette.CardColors _getCardColor(int color) {
    // TODO: replace colors with enumerated values this is so tacky
    switch (color) {
      case 0xFFFFDF6B:
        return Palette.CardColors.yellow;
      case 0xFFFF950F:
        return Palette.CardColors.orange;
      case 0xFFFF93BA:
        return Palette.CardColors.pink;
      case 0xFF9BE988:
        return Palette.CardColors.green;
      case 0xFF7CD0FF:
        return Palette.CardColors.blue;
      case 0xFFCACACA:
        return Palette.CardColors.grey;
      case 0xFFB057F5:
        return Palette.CardColors.purple;
      default:
        return Palette.CardColors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, data);
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: Constants.kCardDecorationStyle,
          child: SlidingUpPanel(
            backdropEnabled: true,
            maxHeight: 0.8 * MediaQuery.of(context).size.height,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34.0),
              topRight: Radius.circular(34.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Constants.kShadowColor,
                  offset: Offset(0, -12),
                  blurRadius: 30),
            ],
            // Swipe-up panel starts here
            panel: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 20),
                      child: Container(
                        width: 42.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFC5CBD6),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Habit settings",
                    style: Constants.kTitle1Style,
                  ),
                  // Add more settings here
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _habitNameController,
                          style: Constants.kBodyLabelStyle,
                          onChanged: (text) {
                            setState(() {
                              data.title = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Habit name',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.check_rounded),
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  WidgetColorPicker(
                    chosenColor: _getCardColor(data.color),
                    onSelectColor: _setColor,
                  ),
                  Text('Frequency', style: Constants.kTitle2Style),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Set Goal', style: Constants.kBodyLabelStyle),
                        Container(
                          width: 80,
                          height: 40,
                          child: TextField(
                            controller: _goalCountController,
                            onChanged: (value) {
                              _setGoalCount(value);
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: Constants.kBodyLabelStyle,
                            textAlign: TextAlign.center,
                            textAlignVertical:
                                TextAlignVertical.center, // not working :(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              hintText: '0',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  WidgetTypePicker(
                    type: data.widgetType,
                    onSelectType: _setWidgetType,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              // widget.removeWidget(widget.index);
                              Navigator.pop(context, data);
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(color: Palette.primary),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Palette.primary,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 36,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              widget.removeWidget(widget.index);
                              Navigator.pop(context, data);
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Palette.primary),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Palette.primary,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TopBackBar(passBack: data),
                  Text(
                    data.title,
                    style: Constants.kLargeTitleStyle,
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_rounded),
                        color: Palette.grey,
                        iconSize: 36,
                        onPressed: _decrementCount,
                      ),
                      RingProgressBar(
                        currentCount: data.currentPeriodCounts,
                        goalCount: data.periodicalGoal,
                        habitType: data.widgetType,
                        color: Color(data.color),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_rounded),
                        color: Palette.grey,
                        iconSize: 36,
                        onPressed: _incrementCount,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  CheckInList(
                    checkIns: data.checkins.reversed.toList(),
                    color: Color(data.color),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
