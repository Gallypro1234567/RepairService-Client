import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import '../utils/ui/extensions.dart';

class ItemNewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: kDefaultPadding),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: kBgDarkColor, borderRadius: BorderRadius.circular(10)),
            child: Material(
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                  onTap: () {
                    print('Hello World');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    // decoration: BoxDecoration(
                    //     color: kBgDarkColor,
                    //     borderRadius: BorderRadius.circular(10)),
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 220,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/image_04.jpg"),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: kDefaultPadding,
                                    right: kDefaultPadding,
                                    top: kDefaultPadding / 2,
                                  ),
                                  child: Text.rich(TextSpan(
                                      text:
                                          "Chương trình khuyến mãi abc  - giá rẻ nhất \n",
                                      children: [
                                        TextSpan(text: 'abc def #### \n'),
                                      ])),
                                ),
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: kDefaultPadding,
                                        right: kDefaultPadding,
                                        bottom: kDefaultPadding / 2),
                                    child: Text.rich(TextSpan(
                                      text: 'Xem chi tiet',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                            color: Colors.orange[800],
                                          ),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ).addNeumorphism(
                    blurRadius: 15,
                    borderRadius: 15,
                    offset: Offset(5, 5),
                    topShadowColor: Colors.white60,
                    bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
