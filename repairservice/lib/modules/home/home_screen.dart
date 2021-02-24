import 'package:repairservice/config/themes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/widgets/item_card.dart';

import 'package:repairservice/widgets/item_menu.dart';
import 'package:repairservice/widgets/item_news_card.dart';
import '../../utils//ui/extensions.dart';
import 'components/list_of_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: kBgDarkColor,
          child: Column(
            children: [
              UserCard(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
                child: Column(
                  children: [
                    ListCategories(size: _size).addNeumorphism(
                      blurRadius: 10,
                      borderRadius: 10,
                      offset: Offset(5, 5),
                      topShadowColor: Colors.white60,
                      bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(text: 'Ưu đãi cho bạn')),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    10, (index) => ItemNewsCard()),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(text: 'tin tức nổi bật')),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    10, (index) => ItemNewsCard()),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
