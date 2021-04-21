import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/dashboard_page.dart';

import 'package:repairservice/modules/home/bloc/home_bloc.dart';

import 'package:shimmer/shimmer.dart';
import 'components/home_background.dart';

import 'components/service_gridview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.role == 0) {
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
                return const Center(child: Text('no services'));
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
      children: [
        //UserCard(),
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
            Container(
              height: AppTheme.fullHeight(context),
              color: Colors.white,
            ),
            // TitleText(
            //   text: "Tin khuyến mãi",
            //   fontSize: 16,
            // ),
            // PreferentialHorizontalView(model: state.preferentials),
            // SizedBox(
            //   height: kDefaultPadding,
            // ),
            // TitleText(
            //   text: "Tin tức nổi bật",
            //   fontSize: 16,
            // ),
            // PreferentialHorizontalView(model: state.preferentials),
            // SizedBox(
            //   height: kDefaultPadding,
            // ),
          ],
        )
      ],
    );
  }
}
