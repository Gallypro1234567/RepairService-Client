import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart'; 
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart'; 
import 'post_of_customer.dart';
import 'post_of_worker.dart';

class ManagerGridViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagerBloc, ManagerState>(
        listener: (context, state) { 
          if (state.pageStatus == PageStatus.deleteSuccess)
            context.read<ManagerBloc>().add(ManagerFetched());
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ManagerBloc>().add(ManagerFetched());
          },
          child: BlocBuilder<ManagerBloc, ManagerState>(
            builder: (context, state) {
              switch (state.pageStatus) {
                case PageStatus.loading:
                  return SplashPage();
                case PageStatus.none:
                  context.read<ManagerBloc>().add(ManagerFetched());
                  return SplashPage();
                case PageStatus.failure:
                  return Center(
                    child: Text("Error"),
                  );
                  break;
                default:
                  return Container(
                    color: LightColor.lightGrey,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) => PostManagerContainer(
                        state: state,
                        index: index,
                      ),
                    ),
                  );
              }
            },
          ),
        ));
  }
}

class PostManagerContainer extends StatelessWidget {
  final ManagerState state;
  final int index;
  const PostManagerContainer({
    Key key,
    this.state,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authenState) {
      switch (authenState.user.isCustomer) {
        case UserType.customer:
          // Customer
          return CustomerContainerBuider(state: state, index: index);
          break;
        // Worker
        case UserType.worker:
          return WorkerContainerBuilder(state: state, index: index);
          break;
        default:
          return Center(
            child: Text("Error"),
          );
      }
    });
  }
}
