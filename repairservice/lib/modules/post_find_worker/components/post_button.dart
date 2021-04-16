import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';

class PostButton extends StatelessWidget {
  final title;
  final Function onPressed;
  final Color color;
  const PostButton({
    Key key,
    this.title,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: LightColor.lightGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
            height: AppTheme.fullHeight(context) * 0.06,
            width: AppTheme.fullWidth(context) * 0.7,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: TitleText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ))),
      ),
      onPressed: onPressed,
    );
  }
}
