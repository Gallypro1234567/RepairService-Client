import 'dart:async';

import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/item_card.dart';

import 'package:repairservice/widgets/item_news_card.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../utils/ui/extensions.dart';
import '../home_work_categories/list_work_categories.dart';
import 'models/home_models.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
                  ListWorkCategories(size: _size),
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
}
