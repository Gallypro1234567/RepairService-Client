import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home_work_categories/work_category_detail.dart';

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';

class ItemWorkCategories extends StatelessWidget {
  final String title;

  const ItemWorkCategories({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: AppTheme.fullHeight(context) * 0.3,
          width: AppTheme.fullWidth(context) * 0.3,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/images/man.png"),
                ),
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Text.rich(TextSpan(
                  text: title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )))
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                SlideFadeRoute(
                    page: WorkCategoriesDetail(
                  title: title,
                )));
          },
        )
      ],
    );
  }
}
