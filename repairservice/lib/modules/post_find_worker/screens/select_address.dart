import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post_find_worker/bloc/postfindworker_bloc.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class SelectAddressPage extends StatelessWidget {
  final List<Service> services;

  const SelectAddressPage({Key key, this.services}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightGrey,
        centerTitle: true,
        title: Text("Chọn danh mục"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state.status) {
              case HomeStatus.loading:
                return SplashPage();
              case HomeStatus.success:
                return ServiceGridview(state: state);
              default:
                return Center(
                  child: TitleText(
                    text: "Lỗi kết nối với máy chủ",
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class ServiceGridview extends StatelessWidget {
  final HomeState state;
  const ServiceGridview({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        return _PostSelectServiceContainer(
          title: state.services[index].name,
          imageUrl: state.services[index].imageUrl,
          backgroundColor: index % 3 == 0
              ? Colors.amber[300]
              : index % 2 == 0
                  ? Colors.green[300]
                  : Colors.blue[300],
          headerColor: index % 3 == 0
              ? Colors.amber
              : index % 2 == 0
                  ? Colors.green
                  : Colors.blue,
        ).ripple(() {
          context.read<PostFindWorkerBloc>().add(PostFindWorkerServiceChanged(
              text: state.services[index].name,
              code: state.services[index].code));
        });
      },
    );
  }
}

class _PostSelectServiceContainer extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color headerColor;
  final Color backgroundColor;

  const _PostSelectServiceContainer({
    Key key,
    this.title,
    this.imageUrl,
    this.headerColor,
    this.backgroundColor,
    this.state,
  }) : super(key: key);

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: AppTheme.fullHeight(context) * 0.05,
              width: AppTheme.fullWidth(context) * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: headerColor),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding / 2,
                    horizontal: kDefaultPadding / 2),
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding / 2,
                    horizontal: kDefaultPadding / 2),
                child: TitleText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
