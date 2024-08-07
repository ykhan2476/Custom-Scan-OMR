import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:omr_reader/Home/home.dart';
import 'package:omr_reader/widget/SavedExams.dart';
import 'package:omr_reader/widget/profile.dart';
import 'package:omr_reader/widget/settings.dart';


class footer extends StatefulWidget {
  const footer({Key? key}) : super(key: key);

  @override
  State<footer> createState() => _footerState();
}

class _footerState extends State<footer> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this, // Use 'this' as vsync
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        labels: const ["Home","Performance ",  "Profile", "Settings"],
        icons: const [Icons.home,Icons.bar_chart,  Icons.people_alt, Icons.settings],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor:Color.fromRGBO(255, 0, 22, 100),
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
        
      ),

      body:TabBarView(
        physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _motionTabBarController,
        children: <Widget>[
          home(),
          SavedExams(),
          ProfilePage(),
          SettingsPage()
        ],
      ),
    );
  }
}

