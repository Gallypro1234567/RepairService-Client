import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/login/bloc/login_bloc.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/home_work_categories/item_work_categories_card.dart';
import 'package:repairservice/widgets/item_card.dart';

import 'package:repairservice/widgets/item_news_card.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../utils/ui/extensions.dart';
import '../home_work_categories/list_work_categories.dart';
import 'models/home_category_model.dart';
import 'models/home_models.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  HomeBloc _homeBloc;

  Widget _listofNewsWidget() {
    return Container(
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .8,
      color: LightColor.lightGrey,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            //childAspectRatio: 1 / 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        //padding: EdgeInsets.only(left: 10),

        scrollDirection: Axis.horizontal,
        children: news
            .map(
              (n) => Padding(
                padding: EdgeInsets.only(
                    top: kDefaultPadding / 2, bottom: kDefaultPadding / 2),
                child: NewsCard(
                  news: n,
                ).ripple(() {},
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget abc(_size, state) {
    return RefreshIndicator(
      onRefresh: () async {
        Completer<Null> completer = new Completer<Null>();
        await Future.delayed(Duration(seconds: 2)).then((onvalue) {
          completer.complete();
          setState(() {});
        });
        return completer.future;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(color: LightColor.lightGrey),
        child: ListView(
            clipBehavior: Clip.hardEdge,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              UserCard(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _listServices(_size, state),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  TitleText(
                    text: "Tin khuyến mãi",
                    fontSize: 16,
                  ),
                  _listofNewsWidget(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  TitleText(
                    text: "Tin tức nổi bật",
                    fontSize: 16,
                  ),
                  _listofNewsWidget(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.failure:
            return const Center(child: Text("state.message"));
          case HomeStatus.success:
            if (state.services.isEmpty) {
              return const Center(child: Text('no services'));
            }
            return abc(_size, state);
          case HomeStatus.loading:
            return const Center(child: Text("Loading"));
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _listServices(_size, state) {
    return Container(
      decoration: BoxDecoration(
          color: kBgDarkColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: _size.height * 0.08,
            decoration: BoxDecoration(
                color: Colors.orange[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Center(child: Text('Dịch vụ nổi bật ')),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Container(
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: workCategories
                    .map((e) => ItemWorkCategories(title: e.name))
                    .toList()),
          ),
        ],
      ),
    ).addNeumorphism(
      blurRadius: 10,
      borderRadius: 10,
      offset: Offset(5, 5),
      topShadowColor: Colors.white60,
      bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
    );
  }
}

 