import 'package:flutter/cupertino.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';

class HomeBackground extends StatelessWidget {
  final List<Widget> children;

  const HomeBackground({Key key, this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(color: LightColor.lightGrey),
      child: ListView(
          clipBehavior: Clip.hardEdge,
          physics: AlwaysScrollableScrollPhysics(),
          children: children),
    );
  }
}
