import 'package:flutter/material.dart';
import '../subviews/WidgetList.dart';
import '../components/ProfileBarView.dart';
import '../../constants/Palette.dart' as Palette;
import '../../Models/SampleWidgetData.dart';

final List<SampleWidgetData> sampleWidgetList = [
  SampleWidgetData(
    routineName: 'Drink Water',
    widgetType: 'daily',
    count: 2,
    goal: 5,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.blue,
  ),
  SampleWidgetData(
    routineName: 'Workout',
    widgetType: 'weekly',
    count: 3,
    goal: 5,
    checkIns: [],
    color: Palette.pink,
  ),
  SampleWidgetData(
    routineName: 'Read a Book',
    widgetType: 'monthly',
    count: 11,
    goal: 20,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.green,
  ),
  SampleWidgetData(
    routineName: 'Sleep Early',
    widgetType: 'weekly',
    count: 2,
    goal: 7,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.yellow,
  ),
  SampleWidgetData(
    routineName: 'Drink Water',
    widgetType: 'daily',
    count: 2,
    goal: 5,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.blue,
  ),
  SampleWidgetData(
    routineName: 'Workout',
    widgetType: 'weekly',
    count: 3,
    goal: 5,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(hours: 2)),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.pink,
  ),
  SampleWidgetData(
    routineName: 'Read a Book',
    widgetType: 'monthly',
    count: 11,
    goal: 20,
    checkIns: [],
    color: Palette.green,
  ),
  SampleWidgetData(
    routineName: 'Sleep Early',
    widgetType: 'weekly',
    count: 2,
    goal: 7,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.yellow,
  ),
  SampleWidgetData(
    routineName: 'Study More You Dummy Get Up and Work',
    widgetType: 'weekly',
    count: 2,
    goal: 7,
    checkIns: [
      new DateTime.now(),
      new DateTime.now().subtract(Duration(days: 1)),
    ],
    color: Palette.yellow,
  ),
];

class MainDashboardPage extends StatefulWidget {
  @override
  _MainDashboardPageState createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  Future<List<SampleWidgetData>> widgetList;

  Future<List<SampleWidgetData>> _fetchWidgetData() {
    // TODO: replace this with actual api wrapper call
    return Future<List<SampleWidgetData>>.delayed(
        const Duration(seconds: 2), () => sampleWidgetList);
  }

  @override
  void initState() {
    super.initState();

    widgetList = _fetchWidgetData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // TODO: implement pull to refresh
          setState(() {
            widgetList = _fetchWidgetData();
          });
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ProfileBarView(
                  firstName: 'Jody',
                  lastName: 'Lin',
                ),
              ),
              FutureBuilder(
                future: widgetList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<SampleWidgetData>> snapshot) {
                  Widget dashboardContent;
                  if (snapshot.hasData) {
                    dashboardContent = WidgetList(
                      widgetList: snapshot.data,
                    );
                  } else if (snapshot.hasError) {
                    dashboardContent = Expanded(
                      child: Center(
                        child: Text('Error loading habit data'),
                      ),
                    );
                  } else {
                    dashboardContent = Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Palette.primary),
                          ),
                          Text('Loading your habits...'),
                        ],
                      ),
                    );
                  }
                  return dashboardContent;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
