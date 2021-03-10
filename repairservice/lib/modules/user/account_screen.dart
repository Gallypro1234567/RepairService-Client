import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/user/models/user_category_model.dart';

import 'package:repairservice/modules/user_history_work/user_history_work_screen.dart';

import 'package:repairservice/utils/ui/animations/slide_enter_exit_route.dart';

import '../../utils/ui/extensions.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget _userAvt() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      width: AppTheme.fullWidth(context),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: kBgDarkColor),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/user_2.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                child: Text.rich(
                  TextSpan(
                    text: "Elly \n",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                        text: 'Thay đổi',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).ripple(() {});
  }

  Widget _itemCategory(index) {
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
                  child: Text(userCategory[index].category).ripple(() {}),
                )),
            Icon(
              Icons.keyboard_arrow_right,
              color: LightColor.darkgrey,
            ),
          ],
        ),
      ),
    ).ripple(() {
      Navigator.push(context,
          EnterExitRoute(exitPage: widget, enterPage: UserHistoryWork()));
    });
  }

  Widget _userCategory() {
    return ListView.builder(
      itemCount: userCategory.length,
      itemBuilder: (context, index) => _itemCategory(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightColor.lightGrey,
      ),
      child: Column(
        children: [
          Expanded(flex: 1, child: _userAvt()),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _userCategory(),
            ),
          )
        ],
      ),
    );
  }
}
