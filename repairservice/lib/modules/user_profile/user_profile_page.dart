import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/my_elevated_button.dart';

import 'package:repairservice/widgets/title_text.dart';

import 'components/user_profile_background.dart';
import 'components/user_profile_input.dart';
import 'components/user_profile_scrollview.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: UserProfileBackground(
        child: UserProfileScrollView(
          children: [
            UserProfileInput(
              hintText: "Họ và Tên",
              prefixIcon: Icons.person_outline,
              suffixIcon: Icons.edit_outlined,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Giới tính",
              prefixIcon: Icons.edit,
              suffixIcon: Icons.edit_outlined,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Email",
              prefixIcon: Icons.person,
              suffixIcon: Icons.edit_outlined,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Địa chỉ",
              prefixIcon: Icons.person,
              suffixIcon: Icons.edit_outlined,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Phone",
              prefixIcon: Icons.person_outline,
              suffixIcon: Icons.edit_outlined,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            TitleText(
              text: "Đổi mật khẩu",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Mật khẩu cũ",
              prefixIcon: Icons.person,
              suffixIcon: Icons.edit_outlined,
              isPassword: true,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Mật khẩu mới",
              prefixIcon: Icons.person,
              suffixIcon: Icons.edit_outlined,
              isPassword: true,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Xác nhận mật khẩu ",
              prefixIcon: Icons.person,
              suffixIcon: Icons.edit_outlined,
              isPassword: true,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            Container(
              width: AppTheme.fullWidth(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyElevatedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    title: "Cập nhật",
                    color: LightColor.orange,
                    isValidated: false,
                    onPressed: null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
