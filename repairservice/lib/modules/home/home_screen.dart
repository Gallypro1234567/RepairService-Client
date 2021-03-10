import 'package:flutter/gestures.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/item_card.dart';

import 'package:repairservice/widgets/item_news_card.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../utils/ui/extensions.dart';
import 'components/list_of_category.dart';
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
    return Container(
      decoration: BoxDecoration(color: LightColor.lightGrey),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserCard(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListCategories(size: _size),
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
            ),
          ],
        ),
      ),
    );
  }
}
