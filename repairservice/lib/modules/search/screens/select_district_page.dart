import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/search/bloc/search_bloc.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class SelectDistrictPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: TitleText(
          text: "Chọn quận, huyện, thị xã",
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
      body: BlocBuilder<SearchBloc, SearchState>(
        buildWhen: (previousState, state) {
          if (previousState.postGetPositionStatus == SearchPositionStatus.loading)
            Navigator.pop(context, true);
          return true;
        },
        builder: (context, state) {
          switch (state.postGetPositionStatus) {
            case SearchPositionStatus.loading:
              return Loading();
              break;
            case SearchPositionStatus.failure:
              return SplashPage();

              break;
            default:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SelectRadioContainer(
                      title: "Tất cả",
                      value: 0,
                      groupValue: int,
                    ).ripple(() {
                      context.read<SearchBloc>().add(
                          SearchDistrictSelectChanged(
                              districtId: -1, districtText: ""));
                      context.read<SearchBloc>().add(SearchFetched());
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    }),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.distrists.length,
                      itemBuilder: (context, index) {
                        return SelectRadioContainer(
                          title: state.distrists[index].title,
                        ).ripple(() {
                          context.read<SearchBloc>().add(
                              SearchDistrictSelectChanged(
                                  districtText: state.distrists[index].title,
                                  districtId: state.distrists[index].id));
                          context.read<SearchBloc>().add(SearchFetched());
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
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

enum Status { yes, no }

class SelectRadioContainer extends StatelessWidget {
  final String title;
  final Function(dynamic) onChanged;
  final Object groupValue;
  final Object value;
  const SelectRadioContainer({
    Key key,
    this.title,
    this.onChanged,
    this.groupValue,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: Responsive.isTablet(context)
          ? AppTheme.fullHeight(context) * .1
          : AppTheme.fullHeight(context) * 0.05,
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
