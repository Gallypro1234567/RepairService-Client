import 'package:flutter/cupertino.dart';

import 'package:repairservice/modules/home/home_page.dart';

import 'package:repairservice/modules/main_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
      '/home': (_) => HomePage(),
    };
  }
}
