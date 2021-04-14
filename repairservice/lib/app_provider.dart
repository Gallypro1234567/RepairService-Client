import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';

import 'app_view.dart';
import 'core/auth/bloc/authentication_bloc.dart';
import 'core/user/login/bloc/login_bloc.dart';
import 'core/user/register/bloc/register_bloc.dart';
import 'core/user/verifyphone/bloc/verifyphone_bloc.dart';

class AppProvider extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const AppProvider(
      {Key key, this.authenticationRepository, this.userRepository})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository,
                )),
        BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => VerifyPhoneBloc()..add(VerifyPhoneInitial()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(userRepository: UserRepository())
            ..add(RegisterInitial()),
        ),
      ], child: AppView()),
    );
  }
}
