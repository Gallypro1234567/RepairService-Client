import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/user/login/components/background.dart';
import 'package:repairservice/widgets/text_field_container.dart';
import 'package:repairservice/widgets/title_text.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: LoginBackground(
          children: [
            Positioned(
              top: kDefaultPadding * 2,
              left: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
              ),
            ),
            Positioned(
              top: kDefaultPadding * 4,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: AppTheme.fullHeight(context) * 0.3,
                      width: AppTheme.fullWidth(context),
                      decoration: BoxDecoration(color: Colors.teal),
                      child: Column(
                        children: [
                          TitleText(
                            text: "Tài Khoản",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/user_2.png"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding / 2),
                      decoration: BoxDecoration(
                          color: AppTheme.lightTheme.backgroundColor),
                      child: Column(
                        children: [
                          TextFormField(
                              scrollPadding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusColor: LightColor.grey,
                                contentPadding:
                                    EdgeInsets.only(top: kDefaultPadding / 2),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey)),
                                prefixIcon: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  child: Icon(
                                    Icons.ac_unit,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: "hindText",
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
