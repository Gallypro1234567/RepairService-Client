import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class SlideFadeRoute extends PageRouteBuilder {
  final Widget page;
  SlideFadeRoute({this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            alwaysIncludeSemantics: true,
            opacity: animation,
            child: child,
          ),
        );
}
