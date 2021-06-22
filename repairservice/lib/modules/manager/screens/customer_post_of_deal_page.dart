import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
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
             buildWhen: (previousState, state) {
              if (previousState.pageStatus == PageStatus.loading)
                Navigator.pop(context, true);
              return true;
            },
            builder: (context, state) {
              switch (state.pageStatus) {
                case PageStatus.loading:
                  return Loading();
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
            height: Responsive.isTablet(context)
                ? AppTheme.fullHeight(context) * .4
                : AppTheme.fullHeight(context) * 0.15,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: post.imageUrl == null
                        //             ? AssetImage("assets/images/default.jpg")
                        //             : NetworkImage(post.imageUrl))),
                        child: post.imageUrl == null
                            ? Image.asset("assets/images/default.jpg")
                            : CachedNetworkImage(
                                imageUrl: post.imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ))),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Expanded(
                    flex: 4,
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
                                      ? post.status == 1
                                          ? "Bạn đã chấp nhận thợ"
                                          : "Có ${post.applyAmount} ứng tuyển"
                                      : "Chưa có thợ ứng tuyển",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: post.applyAmount > 0
                                      ? post.status == 1
                                          ? Colors.green
                                          : Colors.blue
                                      : Colors.amber),
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
                          ? post.status == 1
                              ? Colors.green[300]
                              : Colors.blue[300]
                          : Colors.amber[300]),
                  child: Center(
                    child: Icon(
                      post.applyAmount > 0
                          ? post.status == 1
                              ? Icons.check
                              : Icons.note_add
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
