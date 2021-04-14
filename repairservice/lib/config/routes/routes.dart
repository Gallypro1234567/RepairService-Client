import 'package:flutter/cupertino.dart';
 
import 'package:repairservice/modules/home/home_screen.dart';
import 'package:repairservice/core/user/register/register_page.dart';
 
import 'package:repairservice/modules/main_screen.dart';
import 'package:repairservice/modules/user/account_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
      '/home': (_) => HomePage(),
      '/user': (_) => AccountScreen(),
      '/user/history/work': (_) => AccountScreen(),
      
 
    };
  }
}
