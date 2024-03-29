import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';

import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/components/service_container.dart';
import 'package:repairservice/modules/home/components/shimmer_service_container.dart';
import 'package:repairservice/modules/post_get_list/bloc/postgetlist_bloc.dart';
import 'package:repairservice/modules/post_get_list/post_get_list_page.dart';

import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../utils/ui/extensions.dart';

class ServiceGridview extends StatelessWidget {
  final List<Service> model;

  const ServiceGridview({
    Key key,
    this.model = const <Service>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding / 4),
      width: AppTheme.fullWidth(context),
      height: Responsive.isTablet(context)
          ? model.length > 6
              ? AppTheme.fullHeight(context) * .55
              : AppTheme.fullHeight(context) * .4
          : model.length > 6
              ? AppTheme.fullHeight(context) * .35
              : AppTheme.fullHeight(context) * .2,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: kDefaultPadding / 2, left: kDefaultPadding / 2),
            child: TitleText(
              text: "Khám phá danh mục",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isTablet(context)
                    ? model.length > 12
                        ? 2
                        : 1
                    : model.length > 6
                        ? 2
                        : 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              scrollDirection: Axis.horizontal,
              children: model
                  .map(
                    (obj) => Container(
                        child: BlocBuilder<PostgetlistBloc, PostgetlistState>(
                      builder: (context, state) {
                        return ServiceContainer(
                          title: obj.name,
                          imageUrl: obj.imageUrl,
                        ).ripple(() {
                          context.read<PostgetlistBloc>().add(
                              PostgetlistFetched(
                                  code: obj.code, cityId: -1, districtId: -1));
                          Navigator.push(
                              context,
                              SlideFadeRoute(
                                  page: PostOfServicePage(
                                serviceCode: obj.code,
                                title: obj.name,
                              )));
                        }, borderRadius: BorderRadius.all(Radius.circular(10)));
                      },
                    )),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
