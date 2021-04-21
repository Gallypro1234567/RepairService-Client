import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class ItemPostContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 4,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: AppTheme.fullHeight(context) * 0.15,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(
                  kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/image_02.jpg"))),
              ),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleText(
                        text: "Lắp nguyên bộ máy lạnh treo tường 1 - 1.5hp",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          TitleText(
                            text: "Tp. Hồ Chí Minh",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          TitleText(
                            text: "30 phút trước",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ).ripple(() {
        // Navigator.push(context, SlideFadeRoute(page: PostFindWorkerPage()));
      }),
    );
  }
}
