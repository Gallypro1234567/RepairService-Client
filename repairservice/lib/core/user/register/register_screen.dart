import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/user/register/register_detail.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/text_field_container.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../utils/ui/extensions.dart';
import '../login/components/background.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _phoneControler = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/37691.jpg"),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    TitleText(
                      text: "Thông tin tài khoản ",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    TextFieldContainer(
                      controller: _phoneControler,
                      hindText: "Số điện thoại",
                      icon: Icons.phone_android,
                      isPassword: false,
                      keyboard: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Số điện thoại không được rỗng";
                        }
                      },
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Container(
                        height: AppTheme.fullHeight(context) * 0.08,
                        width: AppTheme.fullWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              colors: [
                                Color(0XFF00796B),
                                Color(0XFF26A69A),
                                Colors.yellow[700]
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(0.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Center(
                          child: TitleText(
                            text: "Tiếp tục",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ).ripple(() {
                        if (_formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              SlideFadeRoute(
                                  page: RegisterDetail(
                                phone: _phoneControler.value.text,
                              )));
                        }
                      }),
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
