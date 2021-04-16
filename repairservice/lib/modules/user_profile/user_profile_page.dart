import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/splash/splash_page.dart';

import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

import 'package:repairservice/widgets/title_text.dart';

import 'bloc/userprofile_bloc.dart';
import 'components/user_elevate_button.dart';

import 'components/user_profile_input.dart';
import 'components/user_profile_scrollview.dart';
import 'package:formz/formz.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        switch (state.status) {
          case UserStatus.empty:
            return SplashPage();
          case UserStatus.loading:
            return SplashPage();
          case UserStatus.success:
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
  final UserState state;
  const UserProfileView({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state.formzstatus.isSubmissionFailure) {
          if (state.checkPass == 1) {
            context
                .read<UserProfileBloc>()
                .add(UserProfileVerifyPasswordChanged(""));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Mật khẩu mới bị trùng')),
              );
          } else if (state.checkPass == 2) {
            context
                .read<UserProfileBloc>()
                .add(UserProfileVerifyPasswordChanged(""));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text(
                        'Mật khẩu mới không trùng khớp, vui lòng xác nhận lại')),
              );
          }
        }
        if (state.status == UserProfileStatus.modified) {
          context.read<UserBloc>().add(UserFetch());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Tài khoản"),
            centerTitle: true,
            bottomOpacity: 0.0,
            elevation: 0.0,
          ),
          body: UserProfileBackground(
            title: state.user.fullname,
            onchangedAvatr: () {},
            children: [
              _FullnameBlocInput(
                fullname: state.user.fullname,
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _SexBlocInput(sex: state.user.sex),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _EmailBlocInput(email: state.user.email),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _AddressBlocInput(address: state.user.address),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _PhoneBlocInput(phone: state.user.phone),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              TitleText(
                text: "Đổi mật khẩu",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _OldPasswordBlocInput(),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _NewPasswordBlocInput(),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _VerifyPasswordBlocInput(),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              _UpdateProfileBlocButton()
            ],
          )),
    );
  }
}

class _UpdateProfileBlocButton extends StatelessWidget {
  const _UpdateProfileBlocButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              context.read<UserProfileBloc>().add(UserProfileUpdateSubmitted());
            },
          ),
        ],
      ),
    );
  }
}

class _VerifyPasswordBlocInput extends StatelessWidget {
  const _VerifyPasswordBlocInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
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
    );
  }
}

class _NewPasswordBlocInput extends StatelessWidget {
  const _NewPasswordBlocInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
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
    );
  }
}

class _OldPasswordBlocInput extends StatelessWidget {
  const _OldPasswordBlocInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
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
    );
  }
}

class _PhoneBlocInput extends StatelessWidget {
  final String phone;
  const _PhoneBlocInput({
    Key key,
    this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserProfileInput(
      hintText: "Phone",
      prefixIcon: Icons.phone_android,
      suffixIcon: Icons.edit_outlined,
      initialValue: phone,
      readOnly: true,
      onchanged: null,
    );
  }
}

class _AddressBlocInput extends StatelessWidget {
  final String address;
  const _AddressBlocInput({
    Key key,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return UserProfileInput(
          hintText: "Địa chỉ",
          prefixIcon: Icons.location_on_outlined,
          suffixIcon: Icons.edit_outlined,
          initialValue: address,
          onchanged: (value) {
            context
                .read<UserProfileBloc>()
                .add(UserProfileAddressChanged(value));
          },
        );
      },
    );
  }
}

class _EmailBlocInput extends StatelessWidget {
  final String email;
  const _EmailBlocInput({
    Key key,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return UserProfileInput(
          hintText: "Email",
          prefixIcon: Icons.email_outlined,
          suffixIcon: Icons.edit_outlined,
          initialValue: email,
          onchanged: (value) {
            context.read<UserProfileBloc>().add(UserProfileEmailChanged(value));
          },
        );
      },
    );
  }
}

class _SexBlocInput extends StatelessWidget {
  final Sex sex;
  const _SexBlocInput({
    Key key,
    this.sex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return UserProfileSelectInput(
          hintText: "Giới tính",
          prefixIcon: FontAwesome.venus_mars,
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
          initialValue: sex == Sex.male
              ? "Nam"
              : sex == Sex.female
                  ? "Nữ"
                  : sex == Sex.orther
                      ? "Khác"
                      : null,
          onSelected: (value) {
            context.read<UserProfileBloc>().add(UserProfileSexChanged(value));
          },
        );
      },
    );
  }
}

class _FullnameBlocInput extends StatelessWidget {
  final fullname;
  const _FullnameBlocInput({
    Key key,
    this.fullname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return UserProfileInput(
          hintText: "Họ và Tên",
          prefixIcon: Icons.person_outline,
          suffixIcon: Icons.edit_outlined,
          initialValue: fullname,
          keyboard: TextInputType.text,
          onchanged: (value) {
            context
                .read<UserProfileBloc>()
                .add(UserProfileFullnnameChanged(value));
          },
        );
      },
    );
  }
}
