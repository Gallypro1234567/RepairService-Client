import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';

import 'package:repairservice/core/auth/authentication.dart';

import 'package:repairservice/modules/admin_dashboard/dashboard_page.dart';

import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post/components/post_item_container.dart';

import 'package:repairservice/modules/post/screens/post_form_page.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';

import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';

import 'package:shimmer/shimmer.dart';
import 'components/home_background.dart';

import 'components/post_recently_gridview.dart';
import 'components/service_gridview.dart';
import '../../utils/ui/extensions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              focusColor: LightColor.grey,
              contentPadding: EdgeInsets.only(top: kDefaultPadding / 2),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: "Bạn cần tìm dịch vụ gì ?",
            ),
          ),
        ),
        leadingWidth: 30,
        leading: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.user.role == 0) {
              return IconButton(
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              );
            }
            return Container();
          },
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
            case HomeStatus.success:
              if (state.services.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return _refreshIndicator(_size, context, state);
            case HomeStatus.initial:
              if (state.services.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return _refreshIndicator(_size, context, state);
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
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton:
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.user.isCustomer) {
            case UserType.customer:
              return Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: FloatingActionButton(
                  backgroundColor: LightColor.lightteal,
                  onPressed: () {
                    Navigator.push(context, SlideFadeRoute(page: PostPage()));
                  },
                  child: Center(child: Icon(Entypo.plus)),
                ),
              );
              break;
            default:
              return Container();
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
              size: _size,
              model: state.services,
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
          ],
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state.status) {
              case HomeStatus.loading:
                return SplashPage();
              case HomeStatus.success:
                return PostRecenttlyGridview(
                  posts: state.postRecently,
                  length: state.hasReachedMax
                      ? state.postRecently.length
                      : state.postRecently.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.postRecently.length
                        ? Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child:
                                  CircularProgressIndicator(strokeWidth: 1.5),
                            ),
                          )
                        : ItemPostContainer(
                            post: state.postRecently[index],
                          ).ripple(() {
                            context.read<PostdetailBloc>().add(
                                PostdetailFetched(
                                    state.postRecently[index].code));
                            Navigator.push(
                                context,
                                SlideFadeRoute(
                                    page: PostDetailPage(
                                        postCode:
                                            state.postRecently[index].code)));
                          });
                  },
                );
              case HomeStatus.initial:
                return PostRecenttlyGridview(
                  posts: state.postRecently,
                  length: state.hasReachedMax
                      ? state.postRecently.length
                      : state.postRecently.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.postRecently.length
                        ? Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child:
                                  CircularProgressIndicator(strokeWidth: 1.5),
                            ),
                          )
                        : ItemPostContainer(
                            post: state.postRecently[index],
                          ).ripple(() {
                            context.read<PostdetailBloc>().add(
                                PostdetailFetched(
                                    state.postRecently[index].code));
                            Navigator.push(context,
                                SlideFadeRoute(page: PostDetailPage()));
                          });
                  },
                );
              default:
                return Center(
                  child: Text("Error"),
                );
            }
          },
        )
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
