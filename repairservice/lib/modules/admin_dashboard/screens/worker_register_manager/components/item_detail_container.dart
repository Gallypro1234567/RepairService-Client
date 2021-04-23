import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';

class ItemDetailContainer extends StatelessWidget {
  final String value;
  final String title;
  const ItemDetailContainer({
    Key key,
    this.value,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.fullHeight(context) * 0.05,
      margin: const EdgeInsets.only(
          top: kDefaultPadding / 2, bottom: kDefaultPadding / 2),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: LightColor.lightGrey, width: 1))),
      child: Row(
        children: [
          TitleText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          Expanded(child: Container()),
          TitleText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
