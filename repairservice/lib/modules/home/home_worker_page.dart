import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/main_screen.dart';

import 'package:repairservice/modules/post_get_list/components/post_search_container.dart';
import 'package:repairservice/modules/search/search_page.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/modules/user/user_profile_page.dart';

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';
import 'components/avatar_container.dart';
import 'components/home_background.dart';
import 'components/post_recently_gridview.dart';
import 'components/service_gridview.dart';
import '../../utils/ui/extensions.dart';

class HomeWorkerPage extends StatefulWidget {
  @override
  _HomeWorkerState createState() => _HomeWorkerState();
}

class _HomeWorkerState extends State<HomeWorkerPage> {
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
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
            children: [
              Expanded(
                child: Hero(
                    tag: 'background',
                    child: SearchContainer().ripple(
                      () {
                        Navigator.push(
                            context, SlideFadeRoute(page: SearchPage()));
                      },
                    )),
              ),
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
                    context, SlideFadeRoute(page: MainPage(selectIndex: 1)));
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
        leading: null,
        backgroundColor: LightColor.lightteal,
        elevation: 0,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previousState, state) {
          if (previousState.status == HomeStatus.loading)
            Navigator.pop(context, true);
          return true;
        },
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.failure:
              return const Center(child: Text("state.message"));
            case HomeStatus.loading:
              return Loading();
            default:
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
