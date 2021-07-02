import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/utils/ui/reponsive.dart';

class ShimmerServiceContainer extends StatelessWidget {
  const ShimmerServiceContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundColor: Colors.black,
              )),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Container(
            height: AppTheme.fullHeight(context) * .02,
            width: AppTheme.fullWidth(context) * .2,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
