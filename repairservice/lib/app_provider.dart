import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/modules/search/bloc/search_bloc.dart';

import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/home_repository/home_repository.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';

import 'app_view.dart';
import 'core/auth/bloc/authentication_bloc.dart';
import 'core/user/login/bloc/login_bloc.dart';
import 'core/user/register/bloc/register_bloc.dart';
import 'core/user/verifyphone/bloc/verifyphone_bloc.dart';

import 'modules/admin_dashboard/screens/customer_detail/bloc/customerdetail_bloc.dart';
import 'modules/admin_dashboard/screens/customer_manager/bloc/customermanager_bloc.dart';
import 'modules/admin_dashboard/screens/post_manager/bloc/postmanager_bloc.dart';
import 'modules/admin_dashboard/screens/service_manager/bloc/servicemanager_bloc.dart';
import 'modules/admin_dashboard/screens/service_manager/screens/bloc/updateservice_bloc.dart';
import 'modules/admin_dashboard/screens/worker_manager.dart/bloc/workermanager_bloc.dart';
import 'modules/admin_dashboard/screens/worker_register_manager/bloc/workerregistermanager_bloc.dart';
import 'modules/home/bloc/home_bloc.dart';
import 'modules/manager/bloc/manager_bloc.dart';
import 'modules/notification/bloc/notification_bloc.dart';
import 'modules/post/bloc/post_bloc.dart';
import 'modules/post_apply/bloc/postapply_bloc.dart';
import 'modules/post_apply_detail/bloc/postapplydetail_bloc.dart';
import 'modules/post_detail/bloc/postdetail_bloc.dart';
import 'modules/post_detail_perfect/bloc/postdetailperfect_bloc.dart';
import 'modules/post_get_list/bloc/postgetlist_bloc.dart';
import 'modules/post_rating/bloc/postrate_bloc.dart';
import 'modules/post_update/bloc/postupdate_bloc.dart';
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
                  postRepository: PostRepository(),
                )..add(HomeFetched())),
        //Search page
        BlocProvider(
            create: (_) => SearchBloc(
                  postRepository: PostRepository(),
                )..add(SearchInitial())),
        // Manager Page
        BlocProvider(
            create: (_) => ManagerBloc(
                  postRepository: PostRepository(),
                )..add(ManagerInitial())),

        // Post
        BlocProvider(
            create: (_) =>
                PostBloc(postRepository: PostRepository())..add(PostInitial())),
        BlocProvider(
            create: (_) => PostgetlistBloc(postRepository: PostRepository())
              ..add(PostgetlistInitial())),
        BlocProvider(
            create: (_) => PostdetailBloc(postRepository: PostRepository())
              ..add(PostdetailInitial())),
        BlocProvider(
            create: (_) => PostUpdateBloc(postRepository: PostRepository())
              ..add(PostUpdateInitial())),
        BlocProvider(
            create: (_) => PostapplyBloc(postRepository: PostRepository())
              ..add(PostApplyInitial())),
        BlocProvider(
            create: (_) => PostapplydetailBloc(
                postRepository: PostRepository(),
                userRepository: UserRepository())
              ..add(PostApplyDetailInitial())),
        BlocProvider(
            create: (_) =>
                PostdetailperfectBloc(postRepository: PostRepository())
                  ..add(PostdetailperfectInitial())),
        // FeedBack
        BlocProvider(
            create: (_) => PostrateBloc(postRepository: PostRepository())
              ..add(PostrateInitial())),

        // Admin - Dashboard
        // ServiceManaGer
        BlocProvider(
            create: (_) => ServicemanagerBloc(
                  dashboardRepository: DashboardRepository(),
                )..add(ServicemanagerInitial())),
        BlocProvider(
            create: (_) => UpdateserviceBloc(
                  dashboardRepository: DashboardRepository(),
                )..add(UpdateserviceInitial())),

        BlocProvider(
            create: (_) => CustomermanagerBloc(
                  dashboardRepository: DashboardRepository(),
                )..add(CustomermanagerInitial())),
        BlocProvider(
            create: (_) => CustomerdetailBloc(
                  dashboardRepository: DashboardRepository(),
                )..add(CustomerDetailInitital())),
        BlocProvider(
            create: (_) => WorkermanagerBloc(
                  dashboardRepository: DashboardRepository(),
                )..add(WorkermanagerInitial())),
        BlocProvider(
            create: (_) => WorkerregistermanagerBloc(
                dashboardRepository: DashboardRepository(),
                postRepository: PostRepository())
              ..add(WorkerregistermanagerFetched())),
        BlocProvider(
            create: (_) => PostmanagerBloc(
                  dashboardRepository: DashboardRepository(),
                  postRepository: PostRepository(),
                )..add(PostmanagerInitial())),
        // Worker
        //WorkerregisterworkBloc
        BlocProvider(
            create: (_) => WorkerregisterworkBloc(
                  userRepository: UserRepository(),
                )..add(WorkerregisterworkInitial())),
        BlocProvider(
            create: (_) => NotificationBloc(
                  postRepository: PostRepository(),
                )..add(NotificationInitial())),
      ], child: AppView()),
    );
  }
}
