import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';

class PostInput extends StatelessWidget {
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String hintText;
  final Function(String) onchanged;
  final bool isPassword;
  final TextInputType keyboard;
  final String initialValue;
  final bool readOnly;
  final bool isCheck;
  const PostInput({
    Key key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onchanged,
    this.isPassword = false,
    this.keyboard = TextInputType.emailAddress,
    this.initialValue,
    this.readOnly = false,
    this.isCheck = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      child: TextFormField(
          initialValue: initialValue,
          obscureText: isPassword,
          onChanged: onchanged,
          readOnly: readOnly,
          keyboardType: keyboard,
          scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey)),
            focusColor: LightColor.lightGrey,
            contentPadding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey)),
            prefixIcon: Container(
              width: 40,
              margin: EdgeInsets.only(right: kDefaultPadding / 2),
              decoration: BoxDecoration(color: Colors.black),
              child: Icon(
                prefixIcon,
                color: Colors.white,
              ),
            ),
            suffixIcon: Icon(
              isCheck ? Icons.check_box_rounded : suffixIcon,
              color: isCheck ? Colors.green[600] : Colors.black,
              size: 30,
            ),
            hintText: hintText,
          )),
    );
  }
}

class PostSearchInput extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final Function(String) onchanged;
  final bool isPassword;
  final TextInputType keyboard;
  final String initialValue;

  const PostSearchInput({
    Key key,
    this.prefixIcon,
    this.hintText,
    this.onchanged,
    this.isPassword = false,
    this.keyboard = TextInputType.emailAddress,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      child: TextFormField(
          initialValue: initialValue,
          obscureText: isPassword,
          onChanged: onchanged,
          keyboardType: keyboard,
          scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey)),
            focusColor: LightColor.lightGrey,
            contentPadding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey)),
            prefixIcon: Icon(
              prefixIcon,
              color: LightColor.grey,
            ),
            hintText: hintText,
          )),
    );
  }
}
