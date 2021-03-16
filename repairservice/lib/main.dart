import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/config/routes/routes.dart';

import 'package:flutter/material.dart';

import 'config/themes/theme_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // theme: ThemeData(),

      routes: Routes.getRoute(),
      initialRoute: "/",
    );
  }
}
