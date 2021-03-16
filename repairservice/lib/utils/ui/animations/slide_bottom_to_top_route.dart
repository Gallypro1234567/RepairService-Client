import 'package:flutter/cupertino.dart';

class SlideBottomToTopRoute extends PageRouteBuilder {
  final Widget page;
  SlideBottomToTopRoute({this.page})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              var begin = Offset(0.0, 0.0);
              var end = Offset(0.0, 0.0);

              var curve = Curves.ease;
              var tween = Tween(begin: begin, end: end);
              var curvedAnim = CurvedAnimation(parent: animation, curve: curve);
              return Align(
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            });
}
