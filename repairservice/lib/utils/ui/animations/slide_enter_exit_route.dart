import 'package:flutter/material.dart';
import 'package:repairservice/modules/user/screens/user_abc.dart';

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              // SlideTransition(
              //   position: new Tween<Offset>(
              //     begin: const Offset(0.0, 0.0),
              //     end: const Offset(-1.0, 0.0),
              //   ).animate(animation),
              //   child: exitPage,
              // ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}
