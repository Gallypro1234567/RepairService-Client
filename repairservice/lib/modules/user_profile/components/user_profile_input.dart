

import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';

class UserProfileInput extends StatelessWidget {
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String hintText;
  final Function(String) onchanged;
  final bool isPassword;
  final TextInputType keyboard;
  final String initialValue;
  final bool readOnly;

  const UserProfileInput({
    Key key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onchanged,
    this.isPassword = false,
    this.keyboard = TextInputType.emailAddress,
    this.initialValue,
    this.readOnly = false,
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
            focusColor: LightColor.grey,
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
              suffixIcon,
              color: Colors.black,
            ),
            hintText: hintText,
          )),
    );
  }
}
