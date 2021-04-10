import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';

class Background extends StatelessWidget {
  final List<Widget> children;
  const Background({
    Key key,
     this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppTheme.fullHeight(context),
      decoration: BoxDecoration(),
      child: Stack(
        alignment: Alignment.center,
        children: children,
      ),
    );
  }
}
