import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'home_admin_page.dart';
import 'home_customer_page.dart';
import 'home_worker_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            if (state.user.role == 0)
              return HomeAdminPage();
            else
              switch (state.user.isCustomer) {
                case UserType.worker:
                  return HomeWorkerPage();
                  break;
                default:
                  return HomeCustomerPage();
              }
            break;
          default:
            return SplashPage();
        }
      },
    );
  }
}
