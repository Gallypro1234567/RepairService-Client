import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
class DescriptionField extends StatelessWidget {
  final Function(String) onChanged;
  final String hindText;
  const DescriptionField({
    Key key,
    this.onChanged,
    this.hindText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 20,
      maxLength: 500,
      onChanged: onChanged,
      scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
      decoration: InputDecoration(
        labelText: '',
        hintText: hindText,
        hintStyle: TextStyle(fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: LightColor.lightteal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: LightColor.lightteal),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: LightColor.lightteal),
        ),
      ),
    );
  }
}

