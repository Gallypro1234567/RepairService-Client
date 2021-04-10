import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/text_field_container.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../utils/ui/extensions.dart';
import '../login/components/background.dart';

class RegisterDetail extends StatefulWidget {
  final String phone;
  const RegisterDetail({
    Key key,
     this.phone,
  }) : super(key: key);

 
  @override
  _RegisterDetailState createState() => _RegisterDetailState();
}

class _RegisterDetailState extends State<RegisterDetail> {
  var _formKey = GlobalKey<FormState>();
  var _pass = new TextEditingController();
  var _passConfirm = new TextEditingController();
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
            Positioned(
              left: 0,
              right: 0,
              top: kDefaultPadding * 4,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //Image.asset("assets/images/37691.jpg"),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      TitleText(
                        text: "Đăng ký tài khoản ",
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      TextFieldContainer(
                        hindText: "Số điện thoại",
                        icon: Icons.phone_android,
                        isPassword: false,
                        keyboard: TextInputType.phone,
                        onchanged: (value) {},
                        initialValue: widget.phone,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      TextFieldContainer(
                        hindText: "Họ và tên",
                        icon: Icons.phone_android,
                        isPassword: false,
                        keyboard: TextInputType.multiline,
                        onchanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Họ và tên không thể trống";
                          }
                        },
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      TextFieldContainer(
                        controller: _pass,
                        hindText: "Mật khẩu",
                        icon: Icons.phone_android,
                        isPassword: true,
                        keyboard: TextInputType.multiline,
                        onchanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Mật khẩu không thể trống";
                          }
                        },
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      TextFieldContainer(
                        controller: _passConfirm,
                        hindText: "Nhập lại mật khẩu",
                        icon: Icons.phone_android,
                        isPassword: true,
                        keyboard: TextInputType.multiline,
                        onchanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập lại mật khẩu";
                          }
                          if (value != _pass.value.text) {
                            return "Mật khẩu không trùng khớp";
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
                                  Colors.tealAccent[700],
                                  Colors.teal[400],
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(0.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: Center(
                            child: TitleText(
                              text: "Đăng ký",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ).ripple(() {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
