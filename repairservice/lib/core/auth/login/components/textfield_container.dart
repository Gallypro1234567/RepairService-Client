import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/widgets/text_field_container.dart';

class TextFieldContainerBloc extends StatelessWidget {
  final String hindText;
  final IconData icon;
  final Function(String) onchanged;
  final bool isPassword;
  final TextInputType keyboard;
  final String initialValue;
  final TextEditingController controller;
  final Function(String) validator;
  final bool readOnly;
  final bool invalid;
  const TextFieldContainerBloc(
      {Key key,
      this.hindText,
      this.icon,
      this.onchanged,
      this.isPassword,
      this.keyboard,
      this.initialValue,
      this.controller,
      this.validator,
      this.readOnly = false,
      this.invalid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      initialValue: initialValue,
      scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
      keyboardType: keyboard,
      obscureText: isPassword,
      readOnly: readOnly,
      onChanged: onchanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey)),
        focusColor: LightColor.grey,
        contentPadding: EdgeInsets.only(top: kDefaultPadding / 2),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey)),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        hintText: hindText,
        errorText: invalid ? 'invalid username' : null,
      ),
    );
  }
}
