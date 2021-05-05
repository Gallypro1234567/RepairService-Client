import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';

class PostApplyDetailContainer extends StatelessWidget {
  final List<Widget> children;
  const PostApplyDetailContainer({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: AppTheme.fullWidth(context),
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
        margin: EdgeInsets.symmetric(
            vertical: kDefaultPadding, horizontal: kDefaultPadding),
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 30,
                color: LightColor.lightGrey,
              ),
              BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 30,
                color: LightColor.lightGrey,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
