import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import '../../../utils/ui/extensions.dart';

class WorkerSelectAddressPage extends StatelessWidget {
  final List<Service> services;
  final Function onPressed;
  const WorkerSelectAddressPage({Key key, this.services, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
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
                return ServiceGridview(state: state, onPressed: onPressed);
              case HomeStatus.initial:
                return ServiceGridview(state: state, onPressed: onPressed);
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
  final Function onPressed;
  const ServiceGridview({
    Key key,
    this.state,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
      builder: (context, wOfState) {
        return GridView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isTablet(context) ? 3 : 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            var wofService = wOfState.serviceRegisters
                .where((e) => e.serviceCode == state.services[index].code);
            if (wofService.isNotEmpty)
              return _PostSelectServiceContainer(
                foregroundDecoration: RotatedCornerDecoration(
                  color: Colors.red,
                  geometry: BadgeGeometry(width: 124, height: 64),
                  textSpan: TextSpan(
                    text: "Đã Đăng ký",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
                title: state.services[index].name,
                imageUrl: state.services[index].imageUrl == null
                    ? ""
                    : state.services[index].imageUrl,
                backgroundColor: Colors.grey[400],
                textColor: Colors.white,
                headerColor: Colors.grey,
                onPressed: null,
              );
            else
              return _PostSelectServiceContainer(
                title: state.services[index].name,
                imageUrl: state.services[index].imageUrl == null
                    ? ""
                    : state.services[index].imageUrl,
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
                onPressed: () {
                  context.read<WorkerregisterworkBloc>().add(
                      WorkerregisterworkServiceChanged(
                          text: state.services[index].name,
                          value: state.services[index].code));
                  Navigator.pop(context);
                },
              );
          },
        );
      },
    );
  }
}

//  context.read<PostFindWorkerBloc>().add(PostFindWorkerServiceChanged(
//               text: state.services[index].name,
//               code: state.services[index].code));
class _PostSelectServiceContainer extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color headerColor;
  final Color backgroundColor;
  final Color textColor;
  final Decoration foregroundDecoration;
  final List<BoxShadow> boxShadow;
  final Function onPressed;
  const _PostSelectServiceContainer({
    Key key,
    this.title,
    this.imageUrl,
    this.headerColor,
    this.backgroundColor,
    this.state,
    this.textColor = Colors.black,
    this.foregroundDecoration,
    this.boxShadow,
    this.onPressed,
  }) : super(key: key);

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: onPressed != null
          ? Container(
              foregroundDecoration: foregroundDecoration,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backgroundColor,
                  boxShadow: boxShadow),
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
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : null,
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
                          color: textColor),
                    ),
                  )
                ],
              ),
            ).ripple(
              onPressed,
              borderRadius: BorderRadius.circular(10),
            )
          : Container(
              foregroundDecoration: foregroundDecoration,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backgroundColor,
                  boxShadow: boxShadow),
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
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : null,
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
                          color: textColor),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
