import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';

import 'package:repairservice/core/auth/my_elevated_button.dart';
import 'package:repairservice/core/user/login/bloc/login_bloc.dart';
import 'package:repairservice/core/user/login/components/textfield_container.dart';

import 'package:repairservice/core/user/verifyphone/verify_phone_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:formz/formz.dart';
import 'components/background.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.statusCode == 400) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Vui lòng kiểm tra kết nối')),
              );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2, vertical: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: AppTheme.fullHeight(context) * 0.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/37691.jpg"))),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      TitleText(
                        text: "Đăng Nhập",
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      _PhoneInput(),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      _PasswordInput(),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      _LoginBlocButton(
                        title: 'Đăng nhập',
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Center(
                        child: TitleText(
                          text: "Hay",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Chưa có tài khoản? ",
                              style: GoogleFonts.muli(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              children: [
                            TextSpan(
                                text: "Đăng ký ngay",
                                style: GoogleFonts.muli(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: VerifyPhonePage()));
                                  })
                          ])),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFieldContainerBloc(
          key: const Key('loginForm_phoneInput_textField'),
          onchanged: (phone) =>
              context.read<LoginBloc>().add(LoginPhoneChanged(phone)),
          hindText: 'Số điện thoại',
          invalid: state.phone.invalid,
          icon: Icons.phone_android,
          isPassword: false,
          keyboard: TextInputType.phone,
          errorText:
              state.phone.invalid ? 'Số điện thoại không được trống' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFieldContainerBloc(
          key: const Key('loginForm_passwordInput_textField'),
          onchanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
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

class _LoginBlocButton extends StatelessWidget {
  final String title;

  const _LoginBlocButton({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : MyElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                title: title,
                color: LightColor.lightteal,
                isValidated: state.status.isValidated,
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class _RegisterBlocButton extends StatelessWidget {
  final String title;

  const _RegisterBlocButton({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenState) {
        return BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, loginState) {
            return loginState.status.isSubmissionInProgress
                ? const CircularProgressIndicator()
                : MyElevatedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    title: title,
                    color: LightColor.lightteal,
                    isValidated: loginState.status.isValidated,
                    onPressed: loginState.status.isValidated
                        ? () {
                            context
                                .read<LoginBloc>()
                                .add(const LoginSubmitted());
                          }
                        : null,
                  );
          },
        );
      },
    );
  }
}
