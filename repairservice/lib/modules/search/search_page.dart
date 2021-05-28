import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post_get_list/components/post_search_container.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.lightteal,
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Hero(tag: 'background', child: SearchContainer()),
                ],
              )),
            ],
          ),
        ),
        leadingWidth: 30,
        leading: null,
        backgroundColor: LightColor.lightteal,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
