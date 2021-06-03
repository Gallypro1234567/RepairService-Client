import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';

import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/bloc/authentication_bloc.dart';
import 'package:repairservice/modules/home/home_page.dart';
import 'package:repairservice/modules/post/post_form_page.dart';

import 'package:repairservice/modules/user/user_profile_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/BottomNavigationBar/bottom_navigation_bar.dart';

import 'manager/manager_page.dart';
import 'notification/notification_screen.dart';
import 'post/bloc/post_bloc.dart';

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
    });
  }

  int _selectedIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    ManagerPage(),
    NotificationScreen(),
    UserProfilePage(),
  ];

  Widget _main(List<Widget> children) {
    return Scaffold(
      backgroundColor: LightColor.lightteal,
      body: Responsive(
        mobile: SafeArea(
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
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              alwaysIncludeSemantics: true,
                              opacity: animation,
                              child: child,
                            );
                          },
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
                      onIconPresedCallback: onBottomIconPressed)),
            ],
          ),
        ),
        desktop: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        alwaysIncludeSemantics: true,
                        opacity: animation,
                        child: HomePage(),
                      );
                    },
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
        tablet: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        alwaysIncludeSemantics: true,
                        opacity: animation,
                        child: HomePage(),
                      );
                    },
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main(_children);
    //return LoginScreen();
  }
}
