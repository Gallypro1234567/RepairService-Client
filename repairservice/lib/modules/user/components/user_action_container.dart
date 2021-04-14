import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/user_history_work/user_history_work_screen.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import '../../../utils/ui//extensions.dart';

class UserActionContainer extends StatelessWidget {
  final String title;

  const UserActionContainer({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.fullWidth(context) * .15,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          shape: BoxShape.rectangle,
          color: kBgDarkColor),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Icon(
              Icons.settings,
              color: LightColor.orange,
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(title).ripple(() {}),
                )),
            Icon(
              Icons.keyboard_arrow_right,
              color: LightColor.darkgrey,
            ),
          ],
        ),
      ),
    );
  }
}
