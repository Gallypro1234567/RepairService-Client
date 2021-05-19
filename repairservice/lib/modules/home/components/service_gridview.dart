import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';

import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/components/service_container.dart';
import 'package:repairservice/modules/post_get_list/bloc/postgetlist_bloc.dart';
import 'package:repairservice/modules/post_get_list/post_get_list_page.dart';

import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../utils/ui/extensions.dart';

class ServiceGridview extends StatelessWidget {
  final List<Service> model;

  const ServiceGridview({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding / 4),
      width: AppTheme.fullWidth(context),
      height: model.length > 5
          ? AppTheme.fullWidth(context) * .62
          : AppTheme.fullWidth(context) * .35,
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
          SizedBox(
            height: kDefaultPadding / 4,
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: model.length > 5 ? 2 : 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
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
                          context
                              .read<PostgetlistBloc>()
                              .add(PostgetlistFetched(obj.code));
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
    // return Container(
    //   decoration: BoxDecoration(
    //       color: kBgDarkColor, borderRadius: BorderRadius.circular(10)),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Container(
    //         height: size.height * 0.08,
    //         decoration: BoxDecoration(
    //             color: Colors.orange[800],
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(10),
    //               topRight: Radius.circular(10),
    //             )),
    //         child: Center(child: Text('Dịch vụ nổi bật ')),
    //       ),
    //       SizedBox(
    //         height: kDefaultPadding / 2,
    //       ),
    //       Container(
    //         child: GridView.count(
    //             physics: const NeverScrollableScrollPhysics(),
    //             shrinkWrap: true,
    //             crossAxisCount: 3,
    //             crossAxisSpacing: 2,
    //             children: model
    //                 .map((e) => ServiceContainer(
    //                       title: e.name,
    //                       imageUrl: e.imageUrl,
    //                     ))
    //                 .toList()),
    //       ),
    //     ],
    //   ),
    // ).addNeumorphism(
    //   blurRadius: 10,
    //   borderRadius: 10,
    //   offset: Offset(5, 5),
    //   topShadowColor: Colors.white60,
    //   bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
    // );
  }
}
