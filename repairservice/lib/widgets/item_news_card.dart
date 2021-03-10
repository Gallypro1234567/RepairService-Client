import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';

import 'package:repairservice/modules/home/models/home_models.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../utils/ui/extensions.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback press;
  const NewsCard({Key key, this.news, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBgDarkColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      //padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(news.image),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TitleText(
                                text: news.name,
                                fontSize: 12,
                              ),
                              TitleText(
                                text: news.caption,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TitleText(
                                text: "Xem chi tiết",
                                fontSize: 14,
                                color: LightColor.orange,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).addNeumorphism(
      blurRadius: 15,
      borderRadius: 15,
      offset: Offset(5, 5),
      topShadowColor: LightColor.lightGrey,
      bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
    );
  }
}
