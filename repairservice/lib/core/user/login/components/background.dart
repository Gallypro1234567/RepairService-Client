import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:repairservice/config/themes/theme_config.dart';

class LoginBackground extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  const LoginBackground({
    Key key,
    this.children, this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      height: AppTheme.fullHeight(context),
      decoration: BoxDecoration(),
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        children: children,
      ),
    );
  }
}
