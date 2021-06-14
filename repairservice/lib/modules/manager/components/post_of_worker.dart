import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/manager/components/post_item_container.dart';
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
import 'slider_container.dart';

class WorkerContainerBuilder extends StatelessWidget {
  const WorkerContainerBuilder({
    Key key,
    @required this.state,
    @required this.index,
  }) : super(key: key);

  final ManagerState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
                      context, SlideFadeRoute(page: PostDetailPerfectPage()));
                }
              : () {
                  context.read<PostdetailBloc>().add(PostdetailCheckWorker(
                        state.posts[index].code,
                      ));
                  context.read<PostdetailBloc>().add(PostdetailFetched(
                        state.posts[index].code,
                      ));
                  Navigator.push(
                      context, SlideFadeRoute(page: PostDetailPage()));
                }),
          isDelete: state.posts[index].status >= 2 ? false : true,
          isCall: state.posts[index].status < 2
              ? true
              : state.posts[index].status == 2 &&
                      state.posts[index].feedbackAmount == 0
                  ? true
                  : false,
          onPressedCall: () {
            context
                .read<ManagerBloc>()
                .add(ManagerOpenPhoneCall(state.posts[index].phone));
          },
          onPressedDetail: () {
            context.read<PostdetailBloc>().add(PostdetailCheckWorker(
                  state.posts[index].code,
                ));

            context.read<PostdetailBloc>().add(PostdetailFetched(
                  state.posts[index].code,
                ));
            Navigator.push(context, SlideFadeRoute(page: PostDetailPage()));
          },
          onPressedDelete: () {
            context.read<ManagerBloc>().add(ManagerWorkerDeleteApply(
                  postCode: state.posts[index].code,
                  customerPhone: state.posts[index].phone,
                ));
          },
        );
      },
    );
  }
}
