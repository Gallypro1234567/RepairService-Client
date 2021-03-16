import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/modules/home_work_categories/work_category_detail.dart';
 

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';

class ItemWorkCategories extends StatelessWidget {
  final String title;

  const ItemWorkCategories({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            SlideFadeRoute(
                page: WorkCategoriesDetail(
              title: title,
            )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/icon_repairman.png"),
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
    );
  }
}
