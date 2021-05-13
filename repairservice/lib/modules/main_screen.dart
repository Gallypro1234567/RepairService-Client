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
import 'package:repairservice/modules/user/user_manager_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/BottomNavigationBar/bottom_navigation_bar.dart';

import 'manager/manager_screen.dart';
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
    ManagerScreen(),
    NotificationScreen(),
    UserManagerPage(),
  ];

  Widget _main(List<Widget> children) {
    return Scaffold(
      backgroundColor: LightColor.lightGrey,
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
            Positioned(
                bottom: AppTheme.fullHeight(context) * .1,
                right: kDefaultPadding / 2,
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    switch (state.user.isCustomer) {
                      case UserType.customer:
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: kDefaultPadding),
                          child: FloatingActionButton(
                            backgroundColor: Colors.cyan,
                            onPressed: () {
                              context.read<PostBloc>().add(PostAddNewPage());
                              Navigator.push(
                                  context, SlideFadeRoute(page: PostPage()));
                            },
                            child: Center(child: Icon(FontAwesome.edit)),
                          ),
                        );
                        break;
                      default:
                        return Container();
                    }
                  },
                ))
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   clipBehavior: Clip.hardEdge,
      //   child: BottomNavigationBar(type: BottomNavigationBarType.fixed, items: [
      //     BottomNavigationBarItem(
      //       label: "heleo",
      //       icon: Icon(Icons.cancel),
      //     ),
      //     BottomNavigationBarItem(label: "heleo", icon: Icon(Icons.cancel)),
      //     BottomNavigationBarItem(
      //       icon: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //         builder: (context, state) {
      //           switch (state.user.isCustomer) {
      //             case UserType.customer:
      //               return FloatingActionButton(
      //                 backgroundColor: LightColor.lightteal,
      //                 onPressed: () {
      //                   context.read<PostBloc>().add(PostAddNewPage());
      //                   Navigator.push(
      //                       context, SlideFadeRoute(page: PostPage()));
      //                 },
      //                 child: Center(child: Icon(Entypo.plus)),
      //               );
      //               break;
      //             default:
      //               return Container();
      //           }
      //         },
      //       ),
      //       label: "",
      //     ),
      //     BottomNavigationBarItem(label: "heleo", icon: Icon(Icons.cancel)),
      //     BottomNavigationBarItem(label: "heleo", icon: Icon(Icons.cancel)),
      //   ]),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main(_children);
    //return LoginScreen();
  }
}
