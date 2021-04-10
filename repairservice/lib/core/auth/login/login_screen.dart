import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import 'package:repairservice/core/auth/login/bloc/login_bloc.dart'; 
import 'package:repairservice/core/auth/login/components/login_form.dart';
import 'package:repairservice/repository/authentication_repository.dart';
 
 
 
class LoginScreen extends StatelessWidget {
   static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: LoginForm(),
    );
  }
}