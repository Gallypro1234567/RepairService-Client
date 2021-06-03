import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/manager/models/event_model.dart';
import 'package:repairservice/modules/manager/screens/customer_approval_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:table_calendar/table_calendar.dart';

import 'components/post_gridview.dart';
import 'screens/customer_post_finish_page.dart';
import 'screens/customer_post_of_deal_page.dart';
import 'screens/worker_apply_page.dart';
import 'screens/worker_finish_page.dart';
import 'screens/worker_process_page.dart';

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
              color: Colors.black,
            );
          },
        ),
        centerTitle: false,
        backgroundColor: Colors.tealAccent[700],
      ),
      //body: ManagerGridViewPage(),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.user.isCustomer) {
            case UserType.worker:
              return PostOfWorker();
              break;
            default:
              return PostOfCustomer();
          }
        },
      ),
    );
  }
}

class PostOfCustomer extends StatelessWidget {
  const PostOfCustomer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
            indicatorColor: LightColor.lightBlue,
            labelColor: LightColor.lightBlue,
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: RichText(
                  text: TextSpan(
                      text: 'Kiểm duyệt ',
                      style: GoogleFonts.muli(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "(*)",
                            style: GoogleFonts.muli(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
              ),
              Tab(
                child: RichText(
                  text: TextSpan(
                      text: 'Giao dịch ',
                      style: GoogleFonts.muli(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "(*)",
                            style: GoogleFonts.muli(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
              ),
              Tab(
                child: RichText(
                  text: TextSpan(
                      text: 'Hoàn thành ',
                      style: GoogleFonts.muli(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "(*)",
                            style: GoogleFonts.muli(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
              ),
            ]),
        body: TabBarView(
          children: [
            CustomerApprovalPage(),
            CustomerPostOfDealPage(),
            CustomerPostFinishPage()
          ],
        ),
      ),
    );
  }
}

class PostOfWorker extends StatelessWidget {
  const PostOfWorker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
            indicatorColor: LightColor.lightBlue,
            labelColor: LightColor.lightBlue,
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: RichText(
                  text: TextSpan(
                      text: 'Ứng tuyển ',
                      style: GoogleFonts.muli(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "(*)",
                            style: GoogleFonts.muli(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
              ),
              Tab(
                child: RichText(
                  text: TextSpan(
                      text: 'Hoàn thành ',
                      style: GoogleFonts.muli(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "(*)",
                            style: GoogleFonts.muli(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ))
                      ]),
                ),
              ),
            ]),
        body: TabBarView(
          children: [WorkerApplyPage(), WorkerFinishPage()],
        ),
      ),
    );
  }
}
