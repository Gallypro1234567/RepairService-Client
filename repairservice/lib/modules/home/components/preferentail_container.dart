import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/repository/home_repository/models/preferential_model.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../utils/ui/extensions.dart';

class PreferentialContainer extends StatelessWidget {
  final Preferential model;

  const PreferentialContainer({Key key, this.model}) : super(key: key);

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
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.cover,
                      image: NetworkImage(model.imageUrl),
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
                                text: model.title,
                                fontSize: 12,
                              ),
                              TitleText(
                                text: model.description,
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
