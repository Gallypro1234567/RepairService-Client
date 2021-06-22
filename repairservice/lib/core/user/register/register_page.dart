import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';

import 'package:repairservice/core/auth/my_elevated_button.dart';
import 'package:repairservice/core/user/login/components/textfield_container.dart';
import 'package:repairservice/core/user/register/bloc/register_bloc.dart';

import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/reponsive.dart';

import 'package:repairservice/widgets/text_field_container.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:formz/formz.dart';

import '../login/components/background.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum SingingCharacter { lafayette, jefferson }

class _RegisterPageState extends State<RegisterPage> {
  SingingCharacter _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Đã có lỗi xảy ra')),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: Responsive.isTablet(context)
                ? AppTheme.fullHeight(context) * .1
                : AppTheme.fullHeight(context) * .06,
            title: TitleText(
              text: "Trang tin chi tiết",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: LightColor.lightteal,
            leadingWidth: 30,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
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
                  _RegisterPhoneInput(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  _RegisterFullnameInput(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  _RegisterPasswordInput(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  _RegisterVerifyPasswordInput(),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return RadioListTile(
                        title: Text("Khách Hàng"),
                        value: UserType.customer,
                        groupValue: state.userType,
                        onChanged: (UserType value) {
                          context
                              .read<RegisterBloc>()
                              .add(RegisterRadioCustomerChanged(value));
                        },
                      );
                    },
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return RadioListTile(
                        title: Text("Thợ"),
                        value: UserType.worker,
                        groupValue: state.userType,
                        onChanged: (UserType value) {
                          context
                              .read<RegisterBloc>()
                              .add(RegisterRadioCustomerChanged(value));
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  _VerifyPhoneBlocButton(title: "Đăng ký")
                ],
              ),
            ),
          ),
        ));
  }
}

class _RegisterPhoneInput extends StatelessWidget {
  const _RegisterPhoneInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFieldContainer(
          hindText: "Số điện thoại",
          icon: Icons.phone_android,
          isPassword: false,
          keyboard: TextInputType.phone,
          onchanged: (value) {},
          initialValue: state.phone.value,
          readOnly: true,
        );
      },
    );
  }
}

class _RegisterFullnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.fullname != current.fullname,
      builder: (context, state) {
        return TextFieldContainerBloc(
          key: const Key('registerform_fullname'),
          onchanged: (value) =>
              context.read<RegisterBloc>().add(RegisterFullnameChanged(value)),
          hindText: 'Họ và tên',
          invalid: state.fullname.invalid,
          icon: Icons.people_alt,
          isPassword: false,
          keyboard: TextInputType.multiline,
          errorText:
              state.fullname.invalid ? 'Họ và tên không được trống' : null,
        );
      },
    );
  }
}

class _RegisterPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFieldContainerBloc(
          key: const Key('registerform_password'),
          onchanged: (value) =>
              context.read<RegisterBloc>().add(RegisterPasswordChanged(value)),
          onFieldSubmitted: (value) => state.verifyPassword.invalid
              ? context.read<RegisterBloc>().add(
                  RegisterVerifyPasswordChanged(state.verifyPassword.value))
              : null,
          hindText: 'Mật khẩu',
          invalid: state.password.invalid,
          icon: Icons.lock,
          isPassword: true,
          keyboard: TextInputType.visiblePassword,
          errorText:
              state.password.invalid ? 'Mật khẩu không được trống' : null,
        );
      },
    );
  }
}

class _RegisterVerifyPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.password.value != current.verifyPassword.value,
      builder: (context, state) {
        return BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) =>
              previous.verifyPassword != current.verifyPassword ||
              current.verifyPassword.value.length > 0,
          builder: (context, state) {
            return TextFieldContainerBloc(
              key: const Key('registerform_verify_password'),
              onFieldSubmitted: (value) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterVerifyPasswordChanged(value));
              },
              hindText: 'Nhập lại mật khẩu',
              invalid: !state.verifyPassword.invalid
                  ? state.verifyPassword.value != state.password.value
                  : false,
              icon: Icons.lock,
              isPassword: true,
              keyboard: TextInputType.visiblePassword,
              errorText: !state.verifyPassword.invalid
                  ? state.verifyPassword.value != state.password.value
                      ? "Mặt khẩu sai"
                      : null
                  : null,
            );
          },
        );
      },
    );
  }
}

class _VerifyPhoneBlocButton extends StatelessWidget {
  final String title;
  const _VerifyPhoneBlocButton({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      // buildWhen: (previous, current) => current.status != previous.status || state.password.value == state.verifyPassword.value,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : MyElevatedButton(
                key: const Key('Verifyform_phone_to_continue_textField'),
                title: title,
                color: LightColor.lightteal,
                isValidated: state.status.isValidated,
                onPressed: state.status.isValidated &&
                        state.password.value == state.verifyPassword.value
                    ? () {
                        context
                            .read<RegisterBloc>()
                            .add(RegisterButtonSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
