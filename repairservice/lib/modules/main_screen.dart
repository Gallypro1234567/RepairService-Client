import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/modules/home/home_page.dart';
import 'package:repairservice/modules/user/user_manager_page.dart';
import 'package:repairservice/widgets/BottomNavigationBar/bottom_navigation_bar.dart';

import 'manager/manager_screen.dart';
import 'notification/notification_screen.dart';

class MainPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MainPage());
  }

  final int selectIndex;
  MainPage({
    Key key,
    this.selectIndex = -1,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;

  void onBottomIconPressed(int index) {
    setState(() {
      _selectedIndex = index;
      // if (widget.selectIndex == -1) {

      // } else {
      //   _selectedIndex = widget.selectIndex;
      // }
    });
  }

  int _selectedIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    ManagerScreen(),
    NotificationScreen(),
    UserManagerPage(),
  ];

  Widget _main(List<Widget> children) {
    return Scaffold(
      backgroundColor: LightColor.lightteal,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                child: Column(
                  children: [
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: children[_selectedIndex],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: CustomBottomNavigationBar(
                    onIconPresedCallback: onBottomIconPressed))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main(_children);
    //return LoginScreen();
  }
}
