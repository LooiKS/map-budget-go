import 'package:budgetgo/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_shape.dart';
import '../user_setting/user_setting.dart';
import './oval_right_clipper.dart';
import './animatedBottomNav.dart';
import '../signout/signout.dart';
import '../trips/trips_main_page.dart';
import '../notification/notification_page.dart';

class MyHomePage extends StatefulWidget {
  final toggleBrightness;

  MyHomePage(
      {Key key, this.title = 'User Settings', @required this.toggleBrightness})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage;
  String appBarTitle = "Home";

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  void onDrawerRowTapped(String choice) {
    print(choice);
    switch (choice) {
      case "My profile":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;

      case "Settings":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                UserSetting(toggleBrightness: widget.toggleBrightness)));
        break;

      case "Notifications":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NotificationPage()));
        break;

      case "Log out":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LogoutPage(toggleBrightness: widget.toggleBrightness)));
        break;
    }
  }

  getPage(int page) {
    switch (page) {
      case 0:
        return Center(
          child: Container(
            child: Text("Home"),
          ),
        );

      case 1:
        return TripsMainPage();

      case 2:
        return Center(
          child: Container(
            child: Text("Budget"),
          ),
        );

      case 3:
        return Center(
          child: Container(
            child: Text("Friends"),
          ),
        );
    }
  }

  void onBottomNavTabTapped(int index) {
    setState(() {
      currentPage = index;
      switch (index) {
        case 0:
          appBarTitle = "Home";
          break;
        case 1:
          appBarTitle = "Trips";
          break;
        case 2:
          appBarTitle = "Budget";
          break;
        case 3:
          appBarTitle = "Friends";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        shape: CustomShapeBorder(),
      ),
      body: getPage(currentPage),
      drawer: buildDrawer(),
      bottomNavigationBar: AnimatedBottomNav(
        currentIndex: currentPage,
        onChange: (index) {
          onBottomNavTabTapped(index);
        },
      ),
    );
  }

  ClipPath buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogoutPage(
                                    toggleBrightness:
                                        widget.toggleBrightness)));
                      },
                    ),
                  ),
                  Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 5,
                        ),
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/as.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(height: 5.0),
                  Text(
                    "Maria Chin",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "@maria97",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  buildDrawerRow(Icons.home, "Home"),
                  buildDivider(),
                  buildDrawerRow(Icons.person_pin, "My profile"),
                  buildDivider(),
                  buildDrawerRow(Icons.notifications, "Notifications",
                      showBadge: true),
                  buildDivider(),
                  buildDrawerRow(Icons.settings, "Settings"),
                  buildDivider(),
                  buildDrawerRow(Icons.power_settings_new, "Log out"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      color: Colors.grey.shade600,
    );
  }

  GestureDetector buildDrawerRow(IconData icon, String title,
      {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(fontSize: 16.0);
    return GestureDetector(
      onTap: () {
        onDrawerRowTapped(title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "2",
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
