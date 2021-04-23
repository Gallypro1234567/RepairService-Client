import 'package:flutter/cupertino.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';

class HomeBackground extends StatelessWidget {
  final List<Widget> children;
  final ScrollController controler;
  const HomeBackground({Key key, this.children, this.controler})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
      decoration: BoxDecoration(color: LightColor.lightGrey),
      child: ListView(
          controller: controler,
          clipBehavior: Clip.hardEdge,
          physics: AlwaysScrollableScrollPhysics(),
          children: children),
    );
  }
}
