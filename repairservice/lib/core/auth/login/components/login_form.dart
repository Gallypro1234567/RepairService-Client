import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/login/bloc/login_bloc.dart';

import 'package:repairservice/core/auth/login/components/textfield_container.dart';

import 'package:repairservice/core/auth/register/register_screen.dart';
import 'package:repairservice/modules/main_screen.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';

import 'package:repairservice/widgets/title_text.dart';
import 'package:formz/formz.dart';
import '../../../../utils/ui/extensions.dart';
import 'background.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        child: Scaffold(
          body: Background(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/37691.jpg"),
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
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      //   child: Container(
                      //     height: AppTheme.fullHeight(context) * 0.08,
                      //     width: AppTheme.fullWidth(context),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       gradient: LinearGradient(
                      //           colors: [
                      //             Colors.tealAccent[700],
                      //             Colors.teal[400],
                      //           ],
                      //           begin: const FractionalOffset(0.0, 0.0),
                      //           end: const FractionalOffset(0.0, 1.0),
                      //           stops: [0.0, 1.0],
                      //           tileMode: TileMode.clamp),
                      //     ),
                      //     child: Center(
                      //       child: TitleText(
                      //         text: "Đăng Nhập",
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ).ripple(() {

                      //   }),
                      // ),
                      //
                      _LoginButton(),
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
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: TitleText(
                              text: "Đăng ký tài khoản",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ).ripple(() {
                          Navigator.push(
                              context, SlideFadeRoute(page: RegisterScreen()));
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
          icon: Icons.phone_android,
          isPassword: true,
          keyboard: TextInputType.visiblePassword,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Login'),
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
