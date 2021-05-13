import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post_get_list/bloc/postgetlist_bloc.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';
import '../post_get_list_page.dart';
import 'select_district_page.dart';

class SelectCityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: "Chọn tỉnh, thành phố",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: LightColor.lightGrey,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<PostgetlistBloc, PostgetlistState>(
        builder: (context, state) {
          switch (state.pageStatus) {
            case PostGetStatus.loading:
              return SplashPage();
              break;
            case PostGetStatus.failure:
              return SplashPage();

              break;
            default:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SelectContainer(
                      title: "Toàn quốc",
                    ).ripple(() {
                      Navigator.pushAndRemoveUntil(
                          context,
                          SlideFadeRoute(page: PostOfServicePage()),
                          (route) => false);
                    }),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.cities.length,
                      itemBuilder: (context, index) {
                        return SelectContainer(
                          title: state.cities[index].title,
                        ).ripple(() {
                          context.read<PostgetlistBloc>().add(
                              PostgetlistCitySelectChanged(
                                  state.cities[index].title));
                          context.read<PostgetlistBloc>().add(
                              PostgetlistDistrictFetched(
                                  state.cities[index].id));
                          Navigator.push(context,
                              SlideFadeRoute(page: SelectDistrictPage()));
                        });
                      },
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}

class SelectContainer extends StatelessWidget {
  final String title;
  const SelectContainer({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: AppTheme.fullHeight(context) * 0.05,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          TitleText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          Expanded(child: Container()),
          Icon(Icons.arrow_right, size: 30)
        ],
      ),
    );
  }
}
