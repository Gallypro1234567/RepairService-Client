import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/home_repository/home_repository.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';

import 'app_view.dart';
import 'core/auth/bloc/authentication_bloc.dart';
import 'core/user/login/bloc/login_bloc.dart';
import 'core/user/register/bloc/register_bloc.dart';
import 'core/user/verifyphone/bloc/verifyphone_bloc.dart';

import 'modules/admin_dashboard/screens/customer_manager/bloc/customermanager_bloc.dart';
import 'modules/admin_dashboard/screens/service_manager/bloc/servicemanager_bloc.dart';
import 'modules/admin_dashboard/screens/worker_manager.dart/bloc/workermanager_bloc.dart';
import 'modules/home/bloc/home_bloc.dart';
import 'modules/post/bloc/post_bloc.dart';
import 'modules/user/bloc/user_bloc.dart';
import 'modules/user_profile/bloc/userprofile_bloc.dart';
import 'modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'repository/post_repository/post_repository.dart';

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
          create: (context) => RegisterBloc(
              repository:
                  RepositoryProvider.of<AuthenticationRepository>(context))
            ..add(RegisterInitial()),
        ),
        // User Page
        BlocProvider(
            create: (_) =>
                UserBloc(userRepository: UserRepository())..add(UserFetch())),
        // Usser Profile Update
        BlocProvider(
            create: (_) => UserProfileBloc(userRepository: UserRepository())
              ..add(UserProfileInitial())),
        // Home page
        BlocProvider(
            create: (_) => HomeBloc(
                  homeRepository: HomeRepository(),
                )..add(HomeFetched())),
        // Post Find Worker Page
        BlocProvider(
            create: (_) =>
                PostBloc(postRepository: PostRepository())..add(PostInitial())),

        // Admin - Dashboard
        // ServiceManaGer
        BlocProvider(
            create: (_) => ServicemanagerBloc(
                  homeRepository: HomeRepository(),
                )..add(ServicemanagerInitial())),
        BlocProvider(
            create: (_) => CustomermanagerBloc(
                  dashboardRepository: DashboardRepository(),
                )..add(CustomermanagerInitial())),
        BlocProvider(
            create: (_) => WorkermanagerBloc(
                  dashboardRepository: DashboardRepository(),
                )..add(WorkermanagerInitial())),

        // Worker
        //WorkerregisterworkBloc
        BlocProvider(
            create: (_) => WorkerregisterworkBloc(
                  userRepository: UserRepository(),
                )..add(WorkerregisterworkInitial())),
      ], child: AppView()),
    );
  }
}
