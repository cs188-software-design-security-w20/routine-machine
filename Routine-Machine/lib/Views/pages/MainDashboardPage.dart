import 'package:flutter/material.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import '../subviews/WidgetList.dart';
import '../components/ProfileBarView.dart';
import '../../constants/Palette.dart' as Palette;

final List<WidgetData> samples = [
  WidgetData.widgetSample1,
  WidgetData.widgetSample2,
  WidgetData.widgetSample3,
  WidgetData.widgetSample1,
  WidgetData.widgetSample2,
  WidgetData.widgetSample3,
];

class MainDashboardPage extends StatefulWidget {
  @override
  _MainDashboardPageState createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  Future<List<WidgetData>> widgetList;

  Future<List<WidgetData>> _fetchWidgetData() {
    // TODO: replace this with actual api wrapper call
    return Future<List<WidgetData>>.delayed(
        const Duration(seconds: 2), () => samples);
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
                    AsyncSnapshot<List<WidgetData>> snapshot) {
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
