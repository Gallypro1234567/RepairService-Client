import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/widgets/title_text.dart';

class PostDetailButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color primaryColor;
  final Color shadowColor;
  final Color textColor;
  const PostDetailButton(
      {Key key,
      this.title,
      this.onPressed,
      this.primaryColor,
      this.shadowColor,
      this.textColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: primaryColor,
          shadowColor: shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: TitleText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ))),
      ),
      onPressed: onPressed,
    );
  }
}
