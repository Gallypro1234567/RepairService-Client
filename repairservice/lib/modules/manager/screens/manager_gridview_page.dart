import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/manager/components/manager_post_item_container.dart';
import 'package:repairservice/modules/post_apply/bloc/postapply_bloc.dart';
import 'package:repairservice/modules/post_apply/post_apply_page.dart';
import 'package:repairservice/modules/post_apply_detail/bloc/postapplydetail_bloc.dart';
import 'package:repairservice/modules/post_apply_detail/post_apply_detail_page.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/post_detail_perfect/bloc/postdetailperfect_bloc.dart';
import 'package:repairservice/modules/post_detail_perfect/post_detail_perfect_page.dart';

import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import '../../../utils/ui/extensions.dart';

class ManagerGridViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagerBloc, ManagerState>(listener: (context, state) {
      if (state.pageStatus == PageStatus.deleteSuccess) {
        context.read<ManagerBloc>().add(ManagerFetched());
      }
    }, child: BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) {
        switch (state.pageStatus) {
          case PageStatus.loading:
            return SplashPage();
          case PageStatus.success:
            return Container(
              color: LightColor.lightGrey,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.posts.length,
                itemBuilder: (context, index) =>
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, authenState) {
                  switch (authenState.user.isCustomer) {
                    case UserType.customer:
                      return BlocBuilder<AuthenticationBloc,
                          AuthenticationState>(
                        builder: (context, authstate) {
                          return SlidableContainer(
                            child: CustomerManagerPostContainer(
                              post: state.posts[index],
                            ).ripple(state.posts[index].status >= 2
                                ? () {
                                    context.read<PostdetailperfectBloc>().add(
                                        PostdetailperfectFetched(
                                            postCode: state.posts[index].code,
                                            isCustomer: true));
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: PostDetailPerfectPage()));
                                  }
                                : () {
                                    context.read<PostapplyBloc>().add(
                                        PostapplyFetched(
                                            state.posts[index].code));
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: PostApplyPage(
                                          postCode: state.posts[index].code,
                                        )));
                                  }),
                            onPressedDetail: () {
                              context
                                  .read<PostdetailBloc>()
                                  .add(PostdetailFetched(
                                    state.posts[index].code,
                                  ));
                              Navigator.push(
                                  context,
                                  SlideFadeRoute(
                                      page: PostDetailPage(
                                    postCode: state.posts[index].code,
                                  )));
                            },
                            onPressedDelete: () {
                              context.read<ManagerBloc>().add(
                                  ManagerCustomerDeletePost(
                                      state.posts[index].code));
                            },
                          );
                        },
                      );
                      break;
                    case UserType.worker:
                      return BlocBuilder<AuthenticationBloc,
                          AuthenticationState>(
                        builder: (context, authstate) {
                          if (state.posts[index].applystatus == -1) {
                            return WorkerManagerPostDisableContainer(
                              post: state.posts[index],
                            );
                          }
                          return SlidableContainer(
                            child: WorkerManagerPostContainer(
                              post: state.posts[index],
                            ).ripple(state.posts[index].applystatus == 2 ||
                                    state.posts[index].applystatus == 3
                                ? () {
                                    context.read<PostdetailperfectBloc>().add(
                                        PostdetailperfectFetched(
                                            postCode: state.posts[index].code,
                                            isCustomer: false));
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: PostDetailPerfectPage()));
                                  }
                                : () {
                                    context
                                        .read<PostdetailBloc>()
                                        .add(PostdetailCheckWorker(
                                          state.posts[index].code,
                                        ));
                                    context
                                        .read<PostdetailBloc>()
                                        .add(PostdetailFetched(
                                          state.posts[index].code,
                                        ));
                                    Navigator.push(context,
                                        SlideFadeRoute(page: PostDetailPage()));
                                  }),
                            onPressedDetail: () {
                              context
                                  .read<PostdetailBloc>()
                                  .add(PostdetailCheckWorker(
                                    state.posts[index].code,
                                  ));

                              context
                                  .read<PostdetailBloc>()
                                  .add(PostdetailFetched(
                                    state.posts[index].code,
                                  ));
                              Navigator.push(context,
                                  SlideFadeRoute(page: PostDetailPage()));
                            },
                            onPressedDelete: () {
                              context
                                  .read<ManagerBloc>()
                                  .add(ManagerWorkerDeleteApply(
                                    state.posts[index].code,
                                  ));
                            },
                          );
                        },
                      );
                      break;
                    default:
                      return Center(
                        child: Text("Error"),
                      );
                  }
                }),
              ),
            );
            break;
          default:
            return SplashPage();
        }
      },
    ));
  }
}

class SlidableContainer extends StatelessWidget {
  final Widget child;
  final Function onPressedDelete;
  final Function onPressedDetail;
  const SlidableContainer({
    Key key,
    this.child,
    this.onPressedDelete,
    this.onPressedDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding / 4),
          child: IconSlideAction(
            caption: 'Chi tiết',
            color: Colors.blue,
            icon: Icons.more_vert,
            onTap: onPressedDetail,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding / 4),
          child: IconSlideAction(
            caption: 'Xóa',
            color: Colors.red,
            icon: Icons.delete,
            onTap: onPressedDelete,
          ),
        ),
      ],
      child: child,
    );
  }
}
