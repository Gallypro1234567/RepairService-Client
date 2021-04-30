import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/service_manager/bloc/servicemanager_bloc.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'bloc/updateservice_bloc.dart';
import 'components/service_detail_image.dart';
import 'components/service_form_content.dart';

class ServiceDetailPage extends StatefulWidget {
  const ServiceDetailPage({
    Key key,
  }) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
            text: "Thông tin chi tiết",
            fontSize: 16,
            fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<UpdateserviceBloc, UpdateserviceState>(
        listener: (context, state) {
          if (state.status == UpdateServiceStatus.submitted) {
            context.read<ServicemanagerBloc>().add(ServicemanagerInitial());
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
          builder: (context, state) {
            switch (state.status) {
              case UpdateServiceStatus.loading:
                return SplashPage();
                break;
              case UpdateServiceStatus.success:
                return DetailBackground();
                break;
              case UpdateServiceStatus.failure:
                return Center(
                  child: Text("Error "),
                );
                break;
              default:
                return SplashPage();
            }
          },
        ),
      ),
    );
  }
}

class DetailBackground extends StatelessWidget {
  const DetailBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: AppTheme.fullWidth(context),
        padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
        margin: EdgeInsets.symmetric(
            vertical: kDefaultPadding, horizontal: kDefaultPadding),
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 30,
                color: LightColor.lightGrey,
              ),
              BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 30,
                color: LightColor.lightGrey,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ServiceImage(), Content()],
        ),
      ),
    );
  }
}
