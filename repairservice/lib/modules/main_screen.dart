import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/modules/home/home_provider.dart';
import 'package:repairservice/modules/home/home_screen.dart';

import 'package:repairservice/modules/user/account_screen.dart';
import 'package:repairservice/repository/home_repository/home_repository.dart';
import 'package:repairservice/widgets/BottomNavigationBar/bottom_navigation_bar.dart';

import 'home/bloc/home_bloc.dart';
import 'manager/manager_screen.dart';
import 'notification/notification_screen.dart';

class MainPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MainPage());
  }

  MainPage({Key key}) : super(key: key);

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
    ManagerScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];

  Widget _main(List<Widget> children) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (_) => HomeBloc( homeRepository: HomeRepository(), )..add(HomeFetched())), 
      ],
      child: Scaffold(
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
                          duration: Duration(milliseconds: 300),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main(_children);
    //return LoginScreen();
  }
}
