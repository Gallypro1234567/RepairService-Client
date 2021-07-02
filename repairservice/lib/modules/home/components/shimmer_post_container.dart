import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostContainer extends StatelessWidget {
  const ShimmerPostContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kDefaultPadding / 6,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * 0.4
            : AppTheme.fullHeight(context) * 0.15,
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
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                ),
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
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: kDefaultPadding / 4),
                        child: Container(
                          height: AppTheme.fullHeight(context) * .02,
                          width: AppTheme.fullWidth(context) * .2,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: kDefaultPadding / 4),
                        child: Container(
                          height: AppTheme.fullHeight(context) * .02,
                          width: AppTheme.fullWidth(context) * .2,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                          Container(
                            height: AppTheme.fullHeight(context) * .02,
                            width: AppTheme.fullWidth(context) * .2,
                            color: Colors.black,
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: Container()),
                          Container(
                            height: AppTheme.fullHeight(context) * .02,
                            width: AppTheme.fullWidth(context) * .2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
