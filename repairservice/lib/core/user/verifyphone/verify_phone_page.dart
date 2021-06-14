import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/my_elevated_button.dart';

import 'package:repairservice/core/user/login/components/textfield_container.dart';
import 'package:repairservice/core/user/register/bloc/register_bloc.dart';
import 'package:repairservice/core/user/register/register_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';

import 'package:repairservice/widgets/title_text.dart';

import '../login/components/background.dart';

import 'package:formz/formz.dart';

import 'bloc/verifyphone_bloc.dart';

class VerifyPhonePage extends StatefulWidget {
  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final _verifyphoneController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        bottomOpacity: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
        title: TitleText(
          text: "Đăng ký tài khoản",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: AppTheme.fullHeight(context) * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/37691.jpg"))),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              TitleText(
                text: "Nhập số điện thoại",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              _PhoneInput(controler: _verifyphoneController),
              SizedBox(
                height: kDefaultPadding,
              ),
              _VerifyPhoneBlocButton(
                title: "Tiếp tục",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  final TextEditingController controler;

  const _PhoneInput({Key key, this.controler}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFieldContainerBloc(
          controller: controler,
          key: const Key('Verifyform_phoneInput_textField'),
          onchanged: (phone) => context
              .read<VerifyPhoneBloc>()
              .add(VerifyPhoneInputChanged(phone)),
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

class _VerifyPhoneBlocButton extends StatelessWidget {
  final String title;
  const _VerifyPhoneBlocButton({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
      buildWhen: (previous, current) => current.status.isValid,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : MyElevatedButton(
                key: const Key('Verifyform_phone_to_continue_textField'),
                title: title,
                color: LightColor.lightteal,
                isValidated: state.status.isValidated,
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<RegisterBloc>()
                            .add(RegisterWithAddPhone(state.phone.value));
                        Navigator.push(
                            context, SlideFadeRoute(page: RegisterPage()));
                      }
                    : null,
              );
      },
    );
  }
}
