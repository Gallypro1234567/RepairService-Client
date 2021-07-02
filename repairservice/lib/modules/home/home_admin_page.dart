import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/dashboard_page.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/notification/notification_pages.dart';
import 'package:repairservice/modules/notification/notification_customer_page.dart';
import 'package:repairservice/modules/splash/loading_pages.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';

import 'package:repairservice/modules/user/user_profile_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';
import 'components/avatar_container.dart';
import 'components/home_background.dart';
import 'components/home_shimmer.dart';
import 'components/post_recently_gridview.dart';
import 'components/service_gridview.dart';
import '../../utils/ui/extensions.dart';

class HomeAdminPage extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
            children: [
              Expanded(
                  child: TitleText(
                text: "Xin chào quản trị viên",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
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
                            text: "59",
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
                    case UserStatus.success:
                      return SizedBox(
                        height: 30,
                        width: 30,
                        child: AvatarContainer(
                          imageUrl: state.user.imageUrl,
                        ).ripple(() {
                          Navigator.push(
                              context, SlideFadeRoute(page: UserProfilePage()));
                        }),
                      );
                    default:
                      return SizedBox(
                          height: 30,
                          width: 30,
                          child: AvatarContainer(
                            imageUrl: "",
                          ));
                      break;
                  }
                },
              )
            ],
          ),
        ),
        leadingWidth: 30,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        backgroundColor: LightColor.lightteal,
        elevation: 0,
      ),
      drawer: DashboardPage(),
      body: BlocBuilder<HomeBloc, HomeState>(
        
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.failure:
              return const Center(child: Text("state.message"));
            case HomeStatus.loading:
              return HomeShimmer();
            default:
             if (state.services.isEmpty) {
                return HomeShimmer();
              }
              return _refreshIndicator(_size, context, state);
          }
        },
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
