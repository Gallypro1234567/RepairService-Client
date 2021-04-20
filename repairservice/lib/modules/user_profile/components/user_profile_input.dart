import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

class UserProfileInput extends StatelessWidget {
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String hintText;
  final Function(String) onchanged;
  final bool isPassword;
  final TextInputType keyboard;
  final String initialValue;
  final bool readOnly;
  final bool isCheck;
  final TextEditingController controller;
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
    this.isCheck = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      child: TextFormField(
          controller: controller,
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
              isCheck ? Icons.check_box_rounded : suffixIcon,
              color: isCheck ? Colors.green[600] : Colors.black,
              size: 30,
            ),
            hintText: hintText,
          )),
    );
  }
}

class UserProfileSelectInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String hintText;
  final Function(String) onchanged;
  final bool isPassword;
  final TextInputType keyboard;
  final String initialValue;
  final bool readOnly;
  final bool isCheck;
  final Function(Sex) onSelected;
  const UserProfileSelectInput({
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
    this.onSelected,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      child: Stack(
        children: [
          TextFormField(
              controller: controller,
              //initialValue: initialValue,
              obscureText: isPassword,
              onChanged: (value) {},
              readOnly: readOnly,
              keyboardType: keyboard,
              scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                focusColor: LightColor.grey,
                contentPadding:
                    EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: PopupMenuButton(
              onSelected: onSelected,
              child: Visibility(visible: false, child: Text('')),
              itemBuilder: (_) => <PopupMenuItem<Sex>>[
                new PopupMenuItem<Sex>(child: new Text('Nam'), value: Sex.male),
                new PopupMenuItem<Sex>(
                    child: new Text('Nữ'), value: Sex.female),
                new PopupMenuItem<Sex>(
                    child: new Text('Khác'), value: Sex.orther),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
