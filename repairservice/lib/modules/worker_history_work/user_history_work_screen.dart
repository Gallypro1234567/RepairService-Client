import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';

import 'package:repairservice/modules/splash/splash_page.dart';

import 'package:repairservice/modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'package:repairservice/modules/worker_history_work/screens/form_register_page.dart';

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../utils/ui/extensions.dart';
import 'screens/post_of_worker.dart';

class WorkerHistoryWorkPage extends StatelessWidget {
  const WorkerHistoryWorkPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
        buildWhen: (previousState, state) {
      if (previousState.status == WorkerRegisterStatus.loading)
        Navigator.pop(context, true);
      return true;
    }, builder: (context, state) {
      switch (state.status) {
        case WorkerRegisterStatus.loading:
          return Loading();
        case WorkerRegisterStatus.loadSuccessed:
          return WorkerHistoryWorkView();
          break;
        case WorkerRegisterStatus.registerSuccessed:
          return WorkerHistoryWorkView();
          break;
        case WorkerRegisterStatus.exitFailure:
          return WorkerHistoryWorkView();
          break;
        default:
          return SplashPage();
      }
    });
  }
}

class WorkerHistoryWorkView extends StatelessWidget {
  const WorkerHistoryWorkView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        backgroundColor: LightColor.lightteal,
        centerTitle: false,
        leadingWidth: 30,
        title: TitleText(
          text: "Danh sách công việc đăng ký",
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<WorkerregisterworkBloc>()
                  .add(WorkerregisterworkServiceRegisterLoad());
            },
            child: ServiceGridview(
              state: state,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColor.lightteal,
        onPressed: () {
          context.read<WorkerregisterworkBloc>().add(WorkerregisterworkNew());
          Navigator.push(context, SlideFadeRoute(page: FormRegisterPage()));
        },
        child: Icon(Entypo.plus),
      ),
    );
  }
}

class ServiceGridview extends StatelessWidget {
  final WorkerregisterworkState state;

  const ServiceGridview({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.serviceRegisters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isTablet(context) ? 3 : 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: _PostSelectServiceContainer(
            code: state.serviceRegisters[index].code,
            title: state.serviceRegisters[index].serviceName,
            imageUrl: state.serviceRegisters[index].serviceImageurl == null
                ? ""
                : state.serviceRegisters[index].serviceImageurl,
            backgroundColor: state.serviceRegisters[index].isApproval == 0
                ? LightColor.lightGrey
                : state.serviceRegisters[index].isApproval == 1
                    ? Colors.green[300]
                    : Colors.red[300],
            headerColor: state.serviceRegisters[index].isApproval == 0
                ? Colors.grey
                : state.serviceRegisters[index].isApproval == 1
                    ? Colors.green
                    : Colors.red,
          ).ripple(
              state.serviceRegisters[index].isApproval == 0
                  ? null
                  : () {
                      context.read<WorkerregisterworkBloc>().add(
                          WorkerregisterworkServiceChanged(
                              text: state.serviceRegisters[index].serviceName,
                              value:
                                  state.serviceRegisters[index].serviceCode));
                      Navigator.push(
                          context, SlideFadeRoute(page: PostofWorkerPage()));
                    },
              borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }
}

class _PostSelectServiceContainer extends StatelessWidget {
  final String title;
  final String code;
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
    this.code,
  }) : super(key: key);

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: backgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: AppTheme.fullHeight(context) * 0.05,
            width: AppTheme.fullWidth(context) * 0.2,
            padding: EdgeInsets.only(left: kDefaultPadding / 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: headerColor),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: 'Mã Code: ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: code,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
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
                      // backgroundImage:
                      //     imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                      child: imageUrl == null
                          ? Image.asset(
                              "assets/images/user_profile_background.jpg")
                          : CachedNetworkImage(
                              imageUrl: imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
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
    );
  }
}
