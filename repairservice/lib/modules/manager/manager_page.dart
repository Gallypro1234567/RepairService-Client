import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/manager/models/event_model.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:table_calendar/table_calendar.dart';

import 'components/post_gridview.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage>
    with TickerProviderStateMixin {
  ManagerBloc managerBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return TitleText(
              text: state.user.isCustomer == UserType.customer
                  ? "Quản lý đăng tin"
                  : "Quản lý công việc",
              fontSize: 16,
              fontWeight: FontWeight.w800,
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[700],
      ),
      body: ManagerGridViewPage(),
    );
  }
}
