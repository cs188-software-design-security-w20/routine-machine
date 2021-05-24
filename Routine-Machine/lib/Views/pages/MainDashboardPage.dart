import 'package:flutter/material.dart';
import 'package:routine_machine/Models/UserProfile.dart';
import 'package:routine_machine/Models/WidgetData.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import '../subviews/WidgetList.dart';
import '../components/ProfileBarView.dart';
import '../../constants/Palette.dart' as Palette;

class MainDashboardPage extends StatefulWidget {
  final Future<List<WidgetData>> widgetList;
  final Function fetchWidgetData;
  final Function removeWidget;
  final Function updateWidget;
  final APIWrapper api = APIWrapper();
  MainDashboardPage({
    this.widgetList,
    this.fetchWidgetData,
    this.removeWidget,
    this.updateWidget,
  });
  @override
  _MainDashboardPageState createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  Future<UserProfile> userData;
  // Future<List<WidgetData>> widgetList;

  @override
  void initState() {
    super.initState();
    userData = _fetchUserData();
    // widgetList = widget.widgetList;
  }

  Future<UserProfile> _fetchUserData() {
    return Future<UserProfile>.delayed(
      const Duration(seconds: 1),
      () => UserProfile(
          userID: "jodylin", username: "jodyLin", firstName: "Jody Lin"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // widget.fetchWidgetData();
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: FutureBuilder(
                  future: userData,
                  builder: (BuildContext context,
                      AsyncSnapshot<UserProfile> snapshot) {
                    Widget profileBarContent;
                    if (snapshot.hasData) {
                      profileBarContent = ProfileBarView(
                        user: snapshot.data,
                      );
                    } else if (snapshot.hasError) {
                      profileBarContent = Expanded(
                        child: Center(
                          child: Text('Error loading profile'),
                        ),
                      );
                    } else {
                      profileBarContent = ProfileBarView(
                        user: UserProfile(firstName: "Loading..."),
                      );
                    }
                    return profileBarContent;
                  },
                ),
              ),
              FutureBuilder(
                future: widget.widgetList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<WidgetData>> snapshot) {
                  Widget dashboardContent;
                  if (snapshot.hasData) {
                    dashboardContent = WidgetList(
                      widgetList: snapshot.data,
                      removeWidget: widget.removeWidget,
                      updateWidget: widget.updateWidget,
                    );
                  } else if (snapshot.hasError) {
                    dashboardContent = Expanded(
                      child: Center(
                        child:
                            Text('Error loading habit data: ${snapshot.error}'),
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
