import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/notification/notification_page.dart';
import 'package:repairservice/modules/notification/notification_screen.dart';
import 'package:repairservice/modules/post/bloc/post_bloc.dart';
import 'package:repairservice/modules/post_get_list/components/post_search_container.dart';
import 'package:repairservice/modules/post/post_form_page.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';

import 'package:repairservice/modules/user/user_profile_page.dart';
import 'package:repairservice/modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';
import 'components/home_background.dart';
import 'components/post_recently_gridview.dart';
import 'components/service_gridview.dart';
import '../../utils/ui/extensions.dart';

class HomeCustomerPage extends StatefulWidget {
  @override
  _HomeCustomerState createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomerPage> {
  final _scrollController = ScrollController();
  HomeBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
            children: [
              Expanded(child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  switch (state.status) {
                    case UserStatus.loading:
                      return Text("");
                      break;
                    case UserStatus.failure:
                      return Text("");
                      break;
                    default:
                      return TitleText(
                        text: "Xin chào ${state.user.fullname}",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      );
                  }
                },
              )),
              SizedBox(
                width: kDefaultPadding,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  Positioned(
                      top: -1,
                      right: -1,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 6,
                              vertical: kDefaultPadding / 6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          alignment: Alignment.center,
                          child: TitleText(
                            text: "1",
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          )))
                ],
              ).ripple(() {
                Navigator.push(
                    context, SlideFadeRoute(page: NotificationPage()));
              }),
              SizedBox(
                width: kDefaultPadding,
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  switch (state.status) {
                    case UserStatus.loading:
                      return SizedBox(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(
                            backgroundImage: null,
                          ));
                      break;
                    case UserStatus.failure:
                      return SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(backgroundImage: null),
                      );
                      break;
                    default:
                      return SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                          backgroundImage: state.user.imageUrl != null
                              ? state.user.imageUrl.isNotEmpty
                                  ? NetworkImage(state.user.imageUrl)
                                  : AssetImage(
                                      "assets/images/user_profile_background.jpg")
                              : AssetImage(
                                  "assets/images/user_profile_background.jpg"),
                        )..ripple(() {
                            Navigator.push(context,
                                SlideFadeRoute(page: UserProfilePage()));
                          }),
                      );
                  }
                },
              )
            ],
          ),
        ),
        leadingWidth: 30,
        leading: null,
        backgroundColor: LightColor.lightteal,
        elevation: 0,
      ),
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              switch (state.status) {
                case HomeStatus.failure:
                  return const Center(child: Text("state.message"));
                case HomeStatus.loading:
                  return Center(
                    child: SizedBox(
                      width: 200.0,
                      height: 100.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: Text(
                          'Loading',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                default:
                  if (state.services.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _refreshIndicator(_size, context, state);
              }
            },
          ),
          Positioned(
              bottom: AppTheme.fullHeight(context) * .1,
              right: kDefaultPadding / 2,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  switch (state.user.isCustomer) {
                    case UserType.customer:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: FloatingActionButton(
                          backgroundColor: Colors.cyan,
                          onPressed: () {
                            context.read<PostBloc>().add(PostAddNewPage());
                            Navigator.push(
                                context, SlideFadeRoute(page: PostPage()));
                          },
                          child: Center(child: Icon(FontAwesome.edit)),
                        ),
                      );
                      break;
                    default:
                      return Container();
                  }
                },
              ))
        ],
      ),
    );
  }

  Widget _refreshIndicator(_size, context, state) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeRefesh());
          },
          child: _homeWidget(_size, state),
        );
      },
    );
  }

  Widget _homeWidget(_size, HomeState state) {
    return HomeBackground(
      controler: _scrollController,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceGridview(
              model: state.services,
            ),
            SizedBox(
              height: kDefaultPadding / 6,
            ),
          ],
        ),
        PostRecently()
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _postBloc.add(HomeFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
