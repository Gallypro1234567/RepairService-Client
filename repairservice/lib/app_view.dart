import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/splash/loading_pages.dart';
import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';

import 'config/themes/theme_config.dart';

import 'core/auth/bloc/authentication_bloc.dart';
import 'core/user/login/login_page.dart';

import 'modules/main_screen.dart';
import 'modules/splash/splash_page.dart';
import 'modules/user/bloc/user_bloc.dart';

class AppView extends StatefulWidget {
  const AppView({
    Key key,
  }) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Repair VN',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      //routes: Routes.getRoute(),
      //initialRoute: "/",
      navigatorKey: _navigatorKey,

      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                context.read<HomeBloc>().add(HomeFetched());
                context.read<UserBloc>().add(UserFetch());
                _navigator.pushAndRemoveUntil(
                    SlideFadeRoute(page: MainPage()), (route) => false);
                break;
              // case AuthenticationStatus.unauthenticated:
              //   _navigator.pushAndRemoveUntil(
              //       LoginPage.route(), (route) => false);
              //   break;
              case AuthenticationStatus.unknown:
                _navigator.pushAndRemoveUntil(
                    SplashPages.route(), (route) => false);
                break;
              default:
                _navigator.pushAndRemoveUntil(
                    LoginPage.route(), (route) => false);
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPages.route(),
    );
  }
}
