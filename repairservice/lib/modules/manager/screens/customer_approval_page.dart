import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class CustomerApprovalPage extends StatefulWidget {
  @override
  _CustomerApprovalPageState createState() => _CustomerApprovalPageState();
}

class _CustomerApprovalPageState extends State<CustomerApprovalPage> {
  void displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Alert"),
        content: new Text("My alert message"),
        actions: [
          CupertinoDialogAction(isDefaultAction: true, child: new Text("Close"))
        ],
      ),
    );
  }

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
                        if (state.posts[index].status < 2)
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
      builder: (context, authstate) {
        return ApprovalPostContainer(
          post: state.posts[index],
        );
      },
    );
  }
}

class ApprovalPostContainer extends StatelessWidget {
  final Post post;
  const ApprovalPostContainer({Key key, this.post}) : super(key: key);

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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: Container()),
                              TitleText(
                                text: post.approval == 1
                                    ? "Đã duyệt thành công"
                                    : post.approval == -1
                                        ? "Duyệt thất bại"
                                        : "Đang đợi duyệt",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: post.approval == 1
                                    ? Colors.green
                                    : post.approval == -1
                                        ? Colors.red
                                        : Colors.amber[600],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding / 4,
                          ),
                          Row(
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
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 5,
                  lightSource: LightSource.top,
                  color: post.approval == 1
                      ? Colors.green[300]
                      : post.approval == -1
                          ? Colors.red[300]
                          : Colors.amber[300]),
              child: Center(
                child: Icon(
                  post.approval == 1
                      ? Icons.check
                      : post.approval == -1
                          ? Icons.close
                          : Icons.warning_amber_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          )
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
          child: const Text('Xem thông tin chi tiết'),
          onPressed: () {
            Navigator.pop(context);
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
