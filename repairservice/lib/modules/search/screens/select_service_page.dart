import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/search/bloc/search_bloc.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class SelectServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: TitleText(
          text: "Chọn dịch vụ",
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
      body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => SingleChildScrollView(
                child: Column(
                  children: [
                    SelectContainer(
                      title: "Tất cả",
                    ).ripple(() {
                      context.read<SearchBloc>().add(SearchServiceChanged(
                          serviceCode: "", serviceText: "Tất cả"));
                      context.read<SearchBloc>().add(SearchFetched());
                      Navigator.pop(context);
                    }),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.services.length,
                      itemBuilder: (context, index) {
                        return SelectContainer(
                          title: state.services[index].name,
                        ).ripple(() {
                          context.read<SearchBloc>().add(SearchServiceChanged(
                              serviceText: state.services[index].name,
                              serviceCode: state.services[index].code));
                          context.read<SearchBloc>().add(SearchFetched());
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              )),
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
