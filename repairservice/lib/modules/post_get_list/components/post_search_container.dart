import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/utils/ui/reponsive.dart';

class SearchContainer extends StatelessWidget {
  final Function(String) onChanged;
  const SearchContainer({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .08
            : AppTheme.fullHeight(context) * .04,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            focusColor: LightColor.lightteal,
            contentPadding: EdgeInsets.only(top: kDefaultPadding / 2),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: "Bạn cần tìm dịch vụ gì ?",
          ),
        ),
      ),
    );
  }
}
