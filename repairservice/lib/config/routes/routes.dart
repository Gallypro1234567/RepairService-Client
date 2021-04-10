import 'package:flutter/cupertino.dart';
import 'package:repairservice/modules/home/home_screen.dart';
import 'package:repairservice/core/auth/login/login_screen.dart';
import 'package:repairservice/core/auth/register/register_detail.dart';
import 'package:repairservice/core/auth/register/register_screen.dart';
import 'package:repairservice/modules/main_screen.dart';
import 'package:repairservice/modules/user/account_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
      '/home': (_) => HomeScreen(),
      '/user': (_) => AccountScreen(),
      '/user/history/work': (_) => AccountScreen(),
      '/login': (_) => LoginScreen(),
      '/register': (_) => RegisterScreen(),
      '/register/detail': (_) => RegisterDetail()
    };
  }
}
