import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/manager/components/post_of_customer.dart';
import 'package:repairservice/modules/manager/components/post_of_worker.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/post_detail_perfect/bloc/postdetailperfect_bloc.dart';
import 'package:repairservice/modules/post_detail_perfect/post_detail_perfect_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class CustomerPostOfDealPage extends StatelessWidget {
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
                      itemBuilder: (context, index) {
                        if ((state.posts[index].status == 0 ||
                                state.posts[index].status == 1) &&
                            state.posts[index].approval == 1)
                          return PostManagerContainer(
                            state: state,
                            index: index,
                          ).ripples(() {
                            context.read<PostdetailBloc>().add(
                                PostdetailFetched(state.posts[index].code));
                            Navigator.push(
                                context,
                                SlideFadeRoute(
                                    page: PostDetailPage(
                                        postCode: state.posts[index].code)));
                          }, () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) => _BottomSheet(
                                code: state.posts[index].code,
                              ),
                            );
                          });
                        return Container();
                      },
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
      return DealPostContainer(
        post: state.posts[index],
      );
    });
  }
}

class DealPostContainer extends StatelessWidget {
  final Post post;
  const DealPostContainer({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 6,
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            height: AppTheme.fullHeight(context) * 0.1,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: post.imageUrl == null
                      ? Image.asset("assets/images/default.jpg")
                      : Image.network(post.imageUrl),
                ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TitleText(
                                    text: post.title == null ? "" : post.title,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: kDefaultPadding / 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: Container()),
                              TitleText(
                                text: post.applyAmount > 0
                                    ? "Có ${post.applyAmount} ứng tuyển"
                                    : "Chưa có thợ ứng tuyển",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding / 4,
                          ),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TitleText(
                                text: "Danh mục: ",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              TitleText(
                                text: post.serviceText,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              Expanded(child: Container()),
                              TitleText(
                                text: TimeAgo.timeAgoSinceDate(post.createAt),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
            top: kDefaultPadding / 2,
            right: kDefaultPadding,
            child: Column(
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 5,
                      lightSource: LightSource.top,
                      color: post.applyAmount > 0
                          ? Colors.green[300]
                          : Colors.amber[300]),
                  child: Center(
                    child: Icon(
                      post.applyAmount > 0
                          ? Icons.check
                          : Icons.warning_amber_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final String code;

  const _BottomSheet({
    Key key,
    this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Xem chi tiết bài đăng'),
          onPressed: () {
            context.read<PostdetailBloc>().add(PostdetailFetched(code));
            Navigator.push(
                context, SlideFadeRoute(page: PostDetailPage(postCode: code)));
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Xóa bài đăng'),
          onPressed: () {
            context.read<ManagerBloc>().add(ManagerCustomerDeletePost(code));
            Navigator.pop(context);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Hủy'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
