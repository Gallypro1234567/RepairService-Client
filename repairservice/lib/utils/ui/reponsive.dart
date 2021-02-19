import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({Key key, this.mobile, this.tablet, this.desktop})
      : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1100) {
          // consider desktop when width is more then 1100
          return desktop;
        } else if (constraints.maxWidth < 1100 && constraints.maxWidth > 650) {
          // consider tablet when width is less then 1100 and  more then 650
          return tablet;
        } else {
          // consider mobile when width is less then 650
          return mobile;
        }
      },
    );
  }
}
