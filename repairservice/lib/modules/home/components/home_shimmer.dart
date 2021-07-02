import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:shimmer/shimmer.dart';

import 'shimmer_post_container.dart';
import 'shimmer_service_container.dart';

class HomeShimmer extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeShimmer());
  }

  const HomeShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: kDefaultPadding / 4),
              width: AppTheme.fullWidth(context),
              height: Responsive.isTablet(context)
                  ? AppTheme.fullHeight(context) * .35
                  : AppTheme.fullHeight(context) * .2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kDefaultPadding / 2, left: kDefaultPadding / 2),
                    child: Container(
                        width: AppTheme.fullWidth(context) * .7,
                        height: AppTheme.fullHeight(context) * .02,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                      ),
                      scrollDirection: Axis.horizontal,
                      children: [
                        ShimmerServiceContainer(),
                        ShimmerServiceContainer(),
                        ShimmerServiceContainer(),
                        ShimmerServiceContainer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: kDefaultPadding / 6,
            ),
            Container(
              padding: EdgeInsets.only(bottom: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: kDefaultPadding * 2,
                    padding: EdgeInsets.only(left: kDefaultPadding / 2),
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: AppTheme.fullWidth(context) * .7,
                        height: AppTheme.fullHeight(context) * .02,
                        color: Colors.black),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) => ShimmerPostContainer(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
