import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/splash/splash_page.dart';

import 'package:repairservice/modules/user/bloc/user_bloc.dart';

import 'package:repairservice/widgets/title_text.dart';

import 'bloc/userprofile_bloc.dart';
import 'components/user_elevate_button.dart';
import 'components/user_profile_background.dart';
import 'components/user_profile_input.dart';
import 'components/user_profile_scrollview.dart';
import 'package:formz/formz.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        switch (state.status) {
          case UserProfileStatus.none:
            return SplashPage();
          case UserProfileStatus.loading:
            return SplashPage();
          case UserProfileStatus.success:
            return UserProfileView(
              state: state,
            );
          default:
            return SplashPage();
        }
      },
    );
  }
}

class UserProfileView extends StatelessWidget {
  final UserProfileState state;
  const UserProfileView({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controler = new TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: UserProfileBackground(
            child: UserProfileScrollView(
          children: [
            BlocBuilder<UserProfileBloc, UserProfileState>(
              // buildWhen: (previous, current) => previous.fullname != current.fullname,
              builder: (context, state) {
                return UserProfileInput(
                  hintText: "Họ và Tên",
                  prefixIcon: Icons.person_outline,
                  suffixIcon: Icons.edit_outlined,
                  initialValue: state.data.fullname,
                  onchanged: (value) {
                    context
                        .read<UserProfileBloc>()
                        .add(UserProfileFullnnameChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return UserProfileSelectInput(
                  hintText: "Giới tính",
                  prefixIcon: Icons.person_pin_circle_outlined,
                  suffixIcon: Icons.edit_outlined,
                  controller: new TextEditingController(
                    text: state.sex == Sex.male
                        ? "Nam"
                        : state.sex == Sex.female
                            ? "Nữ"
                            : state.sex == Sex.orther
                                ? "Khác"
                                : null,
                  ),
                  initialValue: "state.data.fullname",
                  onSelected: (value) {
                    context
                        .read<UserProfileBloc>()
                        .add(UserProfileSexChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return UserProfileInput(
                  hintText: "Email",
                  prefixIcon: Icons.email_outlined,
                  suffixIcon: Icons.edit_outlined,
                  onchanged: (value) {
                    context
                        .read<UserProfileBloc>()
                        .add(UserProfileEmailChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return UserProfileInput(
                  hintText: "Địa chỉ",
                  prefixIcon: Icons.location_on_outlined,
                  suffixIcon: Icons.edit_outlined,
                  onchanged: (value) {
                    context
                        .read<UserProfileBloc>()
                        .add(UserProfileAddressChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            UserProfileInput(
              hintText: "Phone",
              prefixIcon: Icons.phone_android,
              suffixIcon: Icons.edit_outlined,
              onchanged: (value) {},
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
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return UserProfileInput(
                  hintText: "Mật khẩu cũ",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.edit_outlined,
                  isPassword: true,
                  onchanged: (value) {
                    context
                        .read<UserProfileBloc>()
                        .add(UserProfileOldPasswordChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return UserProfileInput(
                  hintText: "Mật khẩu mới",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.edit_outlined,
                  isPassword: true,
                  onchanged: (value) {
                    context
                        .read<UserProfileBloc>()
                        .add(UserProfileNewPasswordChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return UserProfileInput(
                  hintText: "Xác nhận mật khẩu ",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.edit_outlined,
                  isPassword: true,
                  onchanged: (value) {
                    context
                        .read<UserProfileBloc>()
                        .add(UserProfileVerifyPasswordChanged(value));
                  },
                );
              },
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
                  UserProfileButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    title: "Cập nhật",
                    color: LightColor.orange,
                    onPressed: () {
                      context
                          .read<UserProfileBloc>()
                          .add(UserProfileUpdateSubmitted());
                    },
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
