import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/bloc/authentication_bloc.dart';
import 'package:repairservice/modules/home/home_page.dart';
import 'package:repairservice/modules/post_apply/bloc/postapply_bloc.dart';
import 'package:repairservice/modules/post_apply/post_apply_page.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import 'bloc/notification_bloc.dart';

class NotificationCustomerPage extends StatefulWidget {
  @override
  _NotificationCustomerPageState createState() =>
      _NotificationCustomerPageState();
}

class _NotificationCustomerPageState extends State<NotificationCustomerPage> {
  bool a = false;
  @override
  void initState() {
    super.initState();
    a = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: TitleText(
          text: "Thông báo",
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        centerTitle: false,
        backgroundColor: LightColor.lightteal,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return VerticalTabs(
            tabsWidth: Responsive.isTablet(context)
                ? AppTheme.fullWidth(context) * .08
                : AppTheme.fullWidth(context) * .12,
            backgroundColor: LightColor.lightGrey,
            selectedTabBackgroundColor: Colors.white,
            tabBackgroundColor: LightColor.lightGrey,
            indicatorColor: LightColor.lightteal,
            onSelect: (val) {
              if (state.checkall != 1 && val == 0)
                context
                    .read<NotificationBloc>()
                    .add(NotificationFetched(val - 1));
              if (state.checkAdmin != 1 && val == 1)
                context
                    .read<NotificationBloc>()
                    .add(NotificationFetched(val - 1));
              if (state.checkperson != 1 && val == 2)
                context
                    .read<NotificationBloc>()
                    .add(NotificationFetched(val - 1));
              if (state.checkApply != 1 && val == 3)
                context
                    .read<NotificationBloc>()
                    .add(NotificationFetched(val - 1));
            },
            tabs: <Tab>[
              Tab(
                  child: Center(
                child: Stack(
                  children: [
                    Icon(
                      Icons.home,
                      size: 40,
                    ),
                    Positioned(
                      right: 0,
                      child: state.notifiAll
                                  .where((element) => element.isReaded == 0)
                                  .toList()
                                  .length >
                              0
                          ? Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            )
                          : Container(),
                    )
                  ],
                ),
              )),
              Tab(
                  child: Center(
                child: Stack(
                  children: [
                    Icon(
                      Icons.sync_sharp,
                      size: 40,
                    ),
                    Positioned(
                      right: 0,
                      child: state.notifiAll
                                  .where((e) => e.isReaded == 0 && e.type == 0)
                                  .toList()
                                  .length >
                              0
                          ? Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            )
                          : Container(),
                    )
                  ],
                ),
              )),
              Tab(
                  child: Center(
                child: Stack(
                  children: [
                    Icon(
                      Icons.person,
                      size: 40,
                    ),
                    Positioned(
                      right: 0,
                      child: state.notifiAll
                                  .where((e) => e.isReaded == 0 && e.type == 1)
                                  .toList()
                                  .length >
                              0
                          ? Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            )
                          : Container(),
                    )
                  ],
                ),
              )),
              Tab(
                  child: Center(
                child: Stack(
                  children: [
                    Icon(
                      FontAwesome.hand_peace_o,
                      size: 40,
                    ),
                    Positioned(
                      right: 0,
                      child: state.notifiAll
                                  .where((e) => e.isReaded == 0 && e.type == 2)
                                  .toList()
                                  .length >
                              0
                          ? Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            )
                          : Container(),
                    )
                  ],
                ),
              )),
            ],
            contents: <Widget>[
              TabContents(
                type: -1,
              ),
              TabContents(
                type: 0,
              ),
              TabContents(
                type: 1,
              ),
              TabContents(
                type: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}

class TabContents extends StatefulWidget {
  final int type;

  const TabContents({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  State<TabContents> createState() => _TabContentsState();
}

class _TabContentsState extends State<TabContents> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NotificationBloc>().add(NotificationFetched(widget.type));
      },
      child: BlocListener<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state.status == NotificationStatus.submittedSuccess)
            context
                .read<NotificationBloc>()
                .add(NotificationRefeshed(widget.type));
        },
        child: BlocBuilder<NotificationBloc, NotificationState>(
          buildWhen: (previousState, state) {
            if (previousState.status == NotificationStatus.loading)
              Navigator.pop(context, true);
            return true;
          },
          builder: (context, state) {
            switch (state.status) {
              case NotificationStatus.loading:
                return Loading();
              case NotificationStatus.failure:
                return Center(
                  child: Text("Lỗi"),
                );
              default:
                return widget.type == -1 // tất cả
                    ? ListView.builder(
                        itemCount: state.notifiAll.length,
                        itemBuilder: (context, index) => Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 8),
                          child: NotifiContainer(
                            title: state.notifiAll[index].title,
                            content: CheckContent(
                              type: state.notifiAll[index].type,
                              status: state.notifiAll[index].statusAccept,
                              content: state.notifiAll[index].content,
                              postCode: state.notifiAll[index].postCode,
                              sendBy: state.notifiAll[index].sendBy,
                              receiveBy: state.notifiAll[index].receiveBy,
                              sendPhone: state.notifiAll[index].sendPhone,
                              receivePhone: state.notifiAll[index].receivephone,
                              routeToPostDetail: () {
                                context.read<PostdetailBloc>().add(
                                    PostdetailFetched(
                                        state.notifiAll[index].postCode));
                                Navigator.push(
                                    context,
                                    SlideFadeRoute(
                                        page: PostDetailPage(
                                      postCode: state.notifiAll[index].postCode,
                                    )));
                              },
                              routeToApply: () {
                                context.read<PostapplyBloc>().add(
                                    PostapplyFetched(
                                        state.notifiAll[index].postCode));
                                Navigator.push(
                                    context,
                                    SlideFadeRoute(
                                        page: PostApplyPage(
                                      postCode: state.notifiAll[index].postCode,
                                    )));
                              },
                            ),
                            time: state.notifiAll[index].createAt,
                            backgroundColor:
                                state.notifiAll[index].isReaded != 0
                                    ? Colors.white
                                    : state.notifiAll[index].statusAccept != 0
                                        ? Colors.green[50]
                                        : Colors.red[50],
                            iconBorederColor: state.notifiAll[index].type != 0
                                ? state.notifiAll[index].type == 1
                                    ? state.notifiAll[index].statusAccept ==
                                                3 ||
                                            state.notifiAll[index]
                                                    .statusAccept ==
                                                2
                                        ? Colors.green
                                        : Colors.blue
                                    : Colors.amber
                                : Colors.red,
                            icon: state.notifiAll[index].type == 0
                                ? Icon(
                                    Icons.list_alt,
                                    color: Colors.white,
                                  )
                                : state.notifiAll[index].type == 1
                                    ? Icon(
                                        Icons.history,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.history,
                                        color: Colors.white,
                                      ),
                            isReaded: state.notifiAll[index].isReaded == 0
                                ? false
                                : true,
                            onSelected: (val) {
                              context.read<NotificationBloc>().add(
                                  NotificationSubmitted(
                                      code: state.notifiAll[index].code,
                                      type: val));
                            },
                          ),
                        ),
                      )
                    : widget.type == 0 // tin hệ thống
                        ? ListView.builder(
                            itemCount: state.notifiadmin.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(
                                  top: kDefaultPadding / 8),
                              child: NotifiContainer(
                                title: state.notifiadmin[index].title,
                                content: CheckContent(
                                  type: state.notifiadmin[index].type,
                                  status: state.notifiadmin[index].statusAccept,
                                  content: state.notifiadmin[index].content,
                                  postCode: state.notifiadmin[index].postCode,
                                  sendBy: state.notifiadmin[index].sendBy,
                                  receiveBy: state.notifiadmin[index].receiveBy,
                                  sendPhone: state.notifiadmin[index].sendPhone,
                                  receivePhone:
                                      state.notifiadmin[index].receivephone,
                                  routeToPostDetail: () {
                                    context.read<PostdetailBloc>().add(
                                        PostdetailFetched(
                                            state.notifiadmin[index].postCode));
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: PostDetailPage(
                                          postCode:
                                              state.notifiadmin[index].postCode,
                                        )));
                                  },
                                  routeToApply: () {
                                    context.read<PostapplyBloc>().add(
                                        PostapplyFetched(
                                            state.notifiadmin[index].postCode));
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: PostApplyPage(
                                          postCode:
                                              state.notifiadmin[index].postCode,
                                        )));
                                  },
                                ),
                                time: state.notifiadmin[index].createAt,
                                backgroundColor: state
                                            .notifiadmin[index].isReaded !=
                                        0
                                    ? Colors.white
                                    : state.notifiadmin[index].statusAccept != 0
                                        ? Colors.green[50]
                                        : Colors.red[50],
                                iconBorederColor:
                                    state.notifiadmin[index].type != 0
                                        ? state.notifiadmin[index].type == 1
                                            ? state.notifiadmin[index]
                                                            .statusAccept ==
                                                        3 ||
                                                    state.notifiadmin[index]
                                                            .statusAccept ==
                                                        2
                                                ? Colors.green
                                                : Colors.blue
                                            : Colors.amber
                                        : Colors.red,
                                icon: state.notifiadmin[index].type == 0
                                    ? Icon(
                                        Icons.list_alt,
                                        color: Colors.white,
                                      )
                                    : state.notifiadmin[index].type == 1
                                        ? Icon(
                                            Icons.history,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.history,
                                            color: Colors.white,
                                          ),
                                isReaded: state.notifiadmin[index].isReaded == 0
                                    ? false
                                    : true,
                                onSelected: (val) {
                                  context.read<NotificationBloc>().add(
                                      NotificationSubmitted(
                                          code: state.notifiadmin[index].code,
                                          type: val));
                                },
                              ),
                            ),
                          )
                        : widget.type == 2 // tin ứng tuyển
                            ? ListView.builder(
                                itemCount: state.notifiApply.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: kDefaultPadding / 8),
                                  child: NotifiContainer(
                                    title: state.notifiApply[index].title,
                                    content: CheckContent(
                                      type: state.notifiApply[index].type,
                                      status:
                                          state.notifiApply[index].statusAccept,
                                      content: state.notifiApply[index].content,
                                      postCode:
                                          state.notifiApply[index].postCode,
                                      sendBy: state.notifiperson[index].sendBy,
                                      receiveBy:
                                          state.notifiApply[index].receiveBy,
                                      sendPhone:
                                          state.notifiApply[index].sendPhone,
                                      receivePhone:
                                          state.notifiApply[index].receivephone,
                                      routeToPostDetail: () {
                                        context.read<PostdetailBloc>().add(
                                            PostdetailFetched(state
                                                .notifiApply[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostDetailPage(
                                              postCode: state
                                                  .notifiApply[index].postCode,
                                            )));
                                      },
                                      routeToApply: () {
                                        context.read<PostapplyBloc>().add(
                                            PostapplyFetched(state
                                                .notifiApply[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostApplyPage(
                                              postCode: state
                                                  .notifiApply[index].postCode,
                                            )));
                                      },
                                    ),
                                    time: state.notifiApply[index].createAt,
                                    backgroundColor:
                                        state.notifiApply[index].isReaded != 0
                                            ? Colors.white
                                            : state.notifiApply[index]
                                                        .statusAccept !=
                                                    0
                                                ? Colors.green[50]
                                                : Colors.red[50],
                                    iconBorederColor:
                                        state.notifiApply[index].type != 0
                                            ? state.notifiperson[index].type ==
                                                    1
                                                ? state.notifiApply[index]
                                                                .statusAccept ==
                                                            3 ||
                                                        state.notifiApply[index]
                                                                .statusAccept ==
                                                            2
                                                    ? Colors.green
                                                    : Colors.blue
                                                : Colors.amber
                                            : Colors.red,
                                    icon: state.notifiApply[index].type == 0
                                        ? Icon(
                                            Icons.list_alt,
                                            color: Colors.white,
                                          )
                                        : state.notifiApply[index].type == 1
                                            ? Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              ),
                                    isReaded:
                                        state.notifiApply[index].isReaded == 0
                                            ? false
                                            : true,
                                    onSelected: (val) {
                                      context.read<NotificationBloc>().add(
                                          NotificationSubmitted(
                                              code:
                                                  state.notifiApply[index].code,
                                              type: val));
                                    },
                                  ),
                                ),
                              )
                            : // tin giao dịch
                            ListView.builder(
                                itemCount: state.notifiperson.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: kDefaultPadding / 8),
                                  child: NotifiContainer(
                                    title: state.notifiperson[index].title,
                                    content: CheckContent(
                                      type: state.notifiperson[index].type,
                                      status: state
                                          .notifiperson[index].statusAccept,
                                      content:
                                          state.notifiperson[index].content,
                                      postCode:
                                          state.notifiperson[index].postCode,
                                      sendBy: state.notifiperson[index].sendBy,
                                      receiveBy:
                                          state.notifiperson[index].receiveBy,
                                      sendPhone:
                                          state.notifiperson[index].sendPhone,
                                      receivePhone: state
                                          .notifiperson[index].receivephone,
                                      routeToPostDetail: () {
                                        context.read<PostdetailBloc>().add(
                                            PostdetailFetched(state
                                                .notifiperson[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostDetailPage(
                                              postCode: state
                                                  .notifiperson[index].postCode,
                                            )));
                                      },
                                      routeToApply: () {
                                        context.read<PostapplyBloc>().add(
                                            PostapplyFetched(state
                                                .notifiperson[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostApplyPage(
                                              postCode: state
                                                  .notifiperson[index].postCode,
                                            )));
                                      },
                                    ),
                                    time: state.notifiperson[index].createAt,
                                    backgroundColor:
                                        state.notifiperson[index].isReaded != 0
                                            ? Colors.white
                                            : state.notifiperson[index]
                                                        .statusAccept !=
                                                    0
                                                ? Colors.green[50]
                                                : Colors.red[50],
                                    iconBorederColor: state
                                                .notifiperson[index].type !=
                                            0
                                        ? state.notifiperson[index].type == 1
                                            ? state.notifiperson[index]
                                                            .statusAccept ==
                                                        3 ||
                                                    state.notifiperson[index]
                                                            .statusAccept ==
                                                        2
                                                ? Colors.green
                                                : Colors.blue
                                            : Colors.amber
                                        : Colors.red,
                                    icon: state.notifiperson[index].type == 0
                                        ? Icon(
                                            Icons.list_alt,
                                            color: Colors.white,
                                          )
                                        : state.notifiperson[index].type == 1
                                            ? Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              ),
                                    isReaded:
                                        state.notifiperson[index].isReaded == 0
                                            ? false
                                            : true,
                                    onSelected: (val) {
                                      context.read<NotificationBloc>().add(
                                          NotificationSubmitted(
                                              code: state
                                                  .notifiperson[index].code,
                                              type: val));
                                    },
                                  ),
                                ),
                              );
            }
          },
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final int type;

  const TabContent({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state.status == NotificationStatus.none)
          context.read<NotificationBloc>().add(NotificationFetched(type));
        if (state.status == NotificationStatus.submittedSuccess)
          context.read<NotificationBloc>().add(NotificationRefeshed(type));
      },
      child: BlocBuilder<NotificationBloc, NotificationState>(
        buildWhen: (previousState, state) {
          if (previousState.status == NotificationStatus.loading)
            Navigator.of(context).pop();
          return true;
        },
        builder: (context, state) {
          switch (state.status) {
            case NotificationStatus.loading:
              return Loading();
              break;
            case NotificationStatus.failure:
              return Center(
                child: Text("Lỗi"),
              );
            default:
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<NotificationBloc>()
                      .add(NotificationFetched(type));
                },
                child: type == -1 // tất cả
                    ? ListView.builder(
                        itemCount: state.notifiAll.length,
                        itemBuilder: (context, index) => Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 8),
                          child: NotifiContainer(
                            title: state.notifiAll[index].title,
                            content: CheckContent(
                              type: state.notifiAll[index].type,
                              status: state.notifiAll[index].statusAccept,
                              content: state.notifiAll[index].content,
                              postCode: state.notifiAll[index].postCode,
                              sendBy: state.notifiAll[index].sendBy,
                              receiveBy: state.notifiAll[index].receiveBy,
                              sendPhone: state.notifiAll[index].sendPhone,
                              receivePhone: state.notifiAll[index].receivephone,
                              routeToPostDetail: () {
                                context.read<PostdetailBloc>().add(
                                    PostdetailFetched(
                                        state.notifiAll[index].postCode));
                                Navigator.push(
                                    context,
                                    SlideFadeRoute(
                                        page: PostDetailPage(
                                      postCode: state.notifiAll[index].postCode,
                                    )));
                              },
                              routeToApply: () {
                                context.read<PostapplyBloc>().add(
                                    PostapplyFetched(
                                        state.notifiAll[index].postCode));
                                Navigator.push(
                                    context,
                                    SlideFadeRoute(
                                        page: PostApplyPage(
                                      postCode: state.notifiAll[index].postCode,
                                    )));
                              },
                            ),
                            time: state.notifiAll[index].createAt,
                            backgroundColor:
                                state.notifiAll[index].isReaded != 0
                                    ? Colors.white
                                    : state.notifiAll[index].statusAccept != 0
                                        ? Colors.green[50]
                                        : Colors.red[50],
                            iconBorederColor: state.notifiAll[index].type != 0
                                ? state.notifiAll[index].type == 1
                                    ? state.notifiAll[index].statusAccept ==
                                                3 ||
                                            state.notifiAll[index]
                                                    .statusAccept ==
                                                2
                                        ? Colors.green
                                        : Colors.blue
                                    : Colors.amber
                                : Colors.red,
                            icon: state.notifiAll[index].type == 0
                                ? Icon(
                                    Icons.list_alt,
                                    color: Colors.white,
                                  )
                                : state.notifiAll[index].type == 1
                                    ? Icon(
                                        Icons.history,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.history,
                                        color: Colors.white,
                                      ),
                            isReaded: state.notifiAll[index].isReaded == 0
                                ? false
                                : true,
                            onSelected: (val) {
                              context.read<NotificationBloc>().add(
                                  NotificationSubmitted(
                                      code: state.notifiAll[index].code,
                                      type: val));
                            },
                          ),
                        ),
                      )
                    : type == 0 // tin hệ thống
                        ? ListView.builder(
                            itemCount: state.notifiadmin.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(
                                  top: kDefaultPadding / 8),
                              child: NotifiContainer(
                                title: state.notifiadmin[index].title,
                                content: CheckContent(
                                  type: state.notifiadmin[index].type,
                                  status: state.notifiadmin[index].statusAccept,
                                  content: state.notifiadmin[index].content,
                                  postCode: state.notifiadmin[index].postCode,
                                  sendBy: state.notifiadmin[index].sendBy,
                                  receiveBy: state.notifiadmin[index].receiveBy,
                                  sendPhone: state.notifiadmin[index].sendPhone,
                                  receivePhone:
                                      state.notifiadmin[index].receivephone,
                                  routeToPostDetail: () {
                                    context.read<PostdetailBloc>().add(
                                        PostdetailFetched(
                                            state.notifiadmin[index].postCode));
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: PostDetailPage(
                                          postCode:
                                              state.notifiadmin[index].postCode,
                                        )));
                                  },
                                  routeToApply: () {
                                    context.read<PostapplyBloc>().add(
                                        PostapplyFetched(
                                            state.notifiadmin[index].postCode));
                                    Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                            page: PostApplyPage(
                                          postCode:
                                              state.notifiadmin[index].postCode,
                                        )));
                                  },
                                ),
                                time: state.notifiadmin[index].createAt,
                                backgroundColor: state
                                            .notifiadmin[index].isReaded !=
                                        0
                                    ? Colors.white
                                    : state.notifiadmin[index].statusAccept != 0
                                        ? Colors.green[50]
                                        : Colors.red[50],
                                iconBorederColor:
                                    state.notifiadmin[index].type != 0
                                        ? state.notifiadmin[index].type == 1
                                            ? state.notifiadmin[index]
                                                            .statusAccept ==
                                                        3 ||
                                                    state.notifiadmin[index]
                                                            .statusAccept ==
                                                        2
                                                ? Colors.green
                                                : Colors.blue
                                            : Colors.amber
                                        : Colors.red,
                                icon: state.notifiadmin[index].type == 0
                                    ? Icon(
                                        Icons.list_alt,
                                        color: Colors.white,
                                      )
                                    : state.notifiadmin[index].type == 1
                                        ? Icon(
                                            Icons.history,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.history,
                                            color: Colors.white,
                                          ),
                                isReaded: state.notifiadmin[index].isReaded == 0
                                    ? false
                                    : true,
                                onSelected: (val) {
                                  context.read<NotificationBloc>().add(
                                      NotificationSubmitted(
                                          code: state.notifiadmin[index].code,
                                          type: val));
                                },
                              ),
                            ),
                          )
                        : type == 2 // tin ứng tuyển
                            ? ListView.builder(
                                itemCount: state.notifiApply.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: kDefaultPadding / 8),
                                  child: NotifiContainer(
                                    title: state.notifiApply[index].title,
                                    content: CheckContent(
                                      type: state.notifiApply[index].type,
                                      status:
                                          state.notifiApply[index].statusAccept,
                                      content: state.notifiApply[index].content,
                                      postCode:
                                          state.notifiApply[index].postCode,
                                      sendBy: state.notifiperson[index].sendBy,
                                      receiveBy:
                                          state.notifiApply[index].receiveBy,
                                      sendPhone:
                                          state.notifiApply[index].sendPhone,
                                      receivePhone:
                                          state.notifiApply[index].receivephone,
                                      routeToPostDetail: () {
                                        context.read<PostdetailBloc>().add(
                                            PostdetailFetched(state
                                                .notifiApply[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostDetailPage(
                                              postCode: state
                                                  .notifiApply[index].postCode,
                                            )));
                                      },
                                      routeToApply: () {
                                        context.read<PostapplyBloc>().add(
                                            PostapplyFetched(state
                                                .notifiApply[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostApplyPage(
                                              postCode: state
                                                  .notifiApply[index].postCode,
                                            )));
                                      },
                                    ),
                                    time: state.notifiApply[index].createAt,
                                    backgroundColor:
                                        state.notifiApply[index].isReaded != 0
                                            ? Colors.white
                                            : state.notifiApply[index]
                                                        .statusAccept !=
                                                    0
                                                ? Colors.green[50]
                                                : Colors.red[50],
                                    iconBorederColor:
                                        state.notifiApply[index].type != 0
                                            ? state.notifiperson[index].type ==
                                                    1
                                                ? state.notifiApply[index]
                                                                .statusAccept ==
                                                            3 ||
                                                        state.notifiApply[index]
                                                                .statusAccept ==
                                                            2
                                                    ? Colors.green
                                                    : Colors.blue
                                                : Colors.amber
                                            : Colors.red,
                                    icon: state.notifiApply[index].type == 0
                                        ? Icon(
                                            Icons.list_alt,
                                            color: Colors.white,
                                          )
                                        : state.notifiApply[index].type == 1
                                            ? Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              ),
                                    isReaded:
                                        state.notifiApply[index].isReaded == 0
                                            ? false
                                            : true,
                                    onSelected: (val) {
                                      context.read<NotificationBloc>().add(
                                          NotificationSubmitted(
                                              code:
                                                  state.notifiApply[index].code,
                                              type: val));
                                    },
                                  ),
                                ),
                              )
                            : // tin giao dịch
                            ListView.builder(
                                itemCount: state.notifiperson.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: kDefaultPadding / 8),
                                  child: NotifiContainer(
                                    title: state.notifiperson[index].title,
                                    content: CheckContent(
                                      type: state.notifiperson[index].type,
                                      status: state
                                          .notifiperson[index].statusAccept,
                                      content:
                                          state.notifiperson[index].content,
                                      postCode:
                                          state.notifiperson[index].postCode,
                                      sendBy: state.notifiperson[index].sendBy,
                                      receiveBy:
                                          state.notifiperson[index].receiveBy,
                                      sendPhone:
                                          state.notifiperson[index].sendPhone,
                                      receivePhone: state
                                          .notifiperson[index].receivephone,
                                      routeToPostDetail: () {
                                        context.read<PostdetailBloc>().add(
                                            PostdetailFetched(state
                                                .notifiperson[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostDetailPage(
                                              postCode: state
                                                  .notifiperson[index].postCode,
                                            )));
                                      },
                                      routeToApply: () {
                                        context.read<PostapplyBloc>().add(
                                            PostapplyFetched(state
                                                .notifiperson[index].postCode));
                                        Navigator.push(
                                            context,
                                            SlideFadeRoute(
                                                page: PostApplyPage(
                                              postCode: state
                                                  .notifiperson[index].postCode,
                                            )));
                                      },
                                    ),
                                    time: state.notifiperson[index].createAt,
                                    backgroundColor:
                                        state.notifiperson[index].isReaded != 0
                                            ? Colors.white
                                            : state.notifiperson[index]
                                                        .statusAccept !=
                                                    0
                                                ? Colors.green[50]
                                                : Colors.red[50],
                                    iconBorederColor: state
                                                .notifiperson[index].type !=
                                            0
                                        ? state.notifiperson[index].type == 1
                                            ? state.notifiperson[index]
                                                            .statusAccept ==
                                                        3 ||
                                                    state.notifiperson[index]
                                                            .statusAccept ==
                                                        2
                                                ? Colors.green
                                                : Colors.blue
                                            : Colors.amber
                                        : Colors.red,
                                    icon: state.notifiperson[index].type == 0
                                        ? Icon(
                                            Icons.list_alt,
                                            color: Colors.white,
                                          )
                                        : state.notifiperson[index].type == 1
                                            ? Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              ),
                                    isReaded:
                                        state.notifiperson[index].isReaded == 0
                                            ? false
                                            : true,
                                    onSelected: (val) {
                                      context.read<NotificationBloc>().add(
                                          NotificationSubmitted(
                                              code: state
                                                  .notifiperson[index].code,
                                              type: val));
                                    },
                                  ),
                                ),
                              ),
              );
          }
        },
      ),
    );
  }
}

class CheckContent extends StatelessWidget {
  final int type;
  final int status;
  final String content;
  final String postCode;
  final String sendBy;
  final String receiveBy;
  final String sendPhone;
  final String receivePhone;
  final Function routeToPostDetail;
  final Function routeToApply;
  const CheckContent({
    Key key,
    this.type,
    this.content,
    this.postCode,
    this.sendBy,
    this.status,
    this.receiveBy,
    this.sendPhone,
    this.receivePhone,
    this.routeToPostDetail,
    this.routeToApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 1:
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.user.phone == sendPhone) {
              if (status == 1)
                return RichText(
                    text: TextSpan(
                        text: "Mã giao dịch ",
                        style: GoogleFonts.muli(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                        children: [
                      TextSpan(
                          text: "$postCode\n\n",
                          style: GoogleFonts.muli(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = routeToPostDetail),
                      TextSpan(
                          text: "Bạn $content ",
                          style: GoogleFonts.muli(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 14)),
                      TextSpan(
                          text: "$receiveBy",
                          style: GoogleFonts.muli(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = routeToApply),
                      TextSpan(
                          text: " thực hiện giao dịch",
                          style: GoogleFonts.muli(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 14))
                    ]));
              if (status == 3)
                return RichText(
                    text: TextSpan(
                        text: "Mã giao dịch ",
                        style: GoogleFonts.muli(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                        children: [
                      TextSpan(
                          text: "$postCode\n\n",
                          style: GoogleFonts.muli(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = routeToPostDetail),
                      TextSpan(
                          text: "Bạn $content ",
                          style: GoogleFonts.muli(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 14)),
                      TextSpan(
                          text: "$receiveBy",
                          style: GoogleFonts.muli(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = routeToApply),
                      TextSpan(
                          text: " sau khi hoàn tất giao dịch",
                          style: GoogleFonts.muli(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 14))
                    ]));
              return RichText(
                  text: TextSpan(
                      text: "Mã giao dịch ",
                      style: GoogleFonts.muli(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                      children: [
                    TextSpan(
                        text: "$postCode\n\n",
                        style: GoogleFonts.muli(
                            color: Colors.blue,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                            fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = routeToPostDetail),
                    TextSpan(
                        text: "Bạn $content ",
                        style: GoogleFonts.muli(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14)),
                    TextSpan(
                        text: "$receiveBy",
                        style: GoogleFonts.muli(
                            color: Colors.blue,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                            fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = routeToApply),
                    TextSpan(
                        text: " thực hiện giao dịch",
                        style: GoogleFonts.muli(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14))
                  ]));
            }
            return RichText(
                text: TextSpan(
                    text: "Mã giao dịch ",
                    style: GoogleFonts.muli(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 14),
                    children: [
                  TextSpan(
                      text: "$postCode\n\n",
                      style: GoogleFonts.muli(
                          color: Colors.blue,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.underline,
                          fontSize: 14),
                      recognizer: TapGestureRecognizer()
                        ..onTap = routeToPostDetail),
                  TextSpan(
                      text: "$sendBy",
                      style: GoogleFonts.muli(
                          color: Colors.blue,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.underline,
                          fontSize: 14),
                      recognizer: TapGestureRecognizer()..onTap = routeToApply),
                  TextSpan(
                      text: " $content ",
                      style: GoogleFonts.muli(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14)),
                  TextSpan(
                      text: "giao dịch",
                      style: GoogleFonts.muli(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14))
                ]));
          },
        );

        break;
      case 2:
        return RichText(
          text: TextSpan(
              text: "Mã bài đăng ",
              style: GoogleFonts.muli(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
              children: [
                TextSpan(
                    text: "$postCode\n\n",
                    style: GoogleFonts.muli(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = routeToPostDetail),
                TextSpan(
                    text: "$sendBy",
                    style: GoogleFonts.muli(
                        color: Colors.blue,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                        fontSize: 14),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = routeToApply),
                TextSpan(
                    text: " $content.",
                    style: GoogleFonts.muli(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 14)),
              ]),
        );
        break;
      default:
        return RichText(
            text: TextSpan(
                style: GoogleFonts.muli(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
                text: "Bài đăng ",
                children: [
              TextSpan(
                  text: "$postCode ",
                  style: GoogleFonts.muli(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                      fontSize: 14),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, SlideFadeRoute(page: HomePage()));
                      print('adsdas');
                    }),
              TextSpan(
                  text: "$content bởi quản trị viên",
                  style: GoogleFonts.muli(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14))
            ]));
    }
  }
}

class NotifiContainer extends StatefulWidget {
  final String title;
  final String time;
  final Widget content;
  final Icon icon;
  final bool isReaded;
  final Color iconBorederColor;
  final Color backgroundColor;
  final Function(int) onSelected;
  const NotifiContainer({
    Key key,
    this.title,
    this.time,
    this.content,
    this.isReaded = false,
    this.onSelected,
    this.icon,
    this.backgroundColor,
    this.iconBorederColor,
  }) : super(key: key);

  @override
  State<NotifiContainer> createState() => _NotifiContainerState();
}

class _NotifiContainerState extends State<NotifiContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(kDefaultPadding / 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.iconBorederColor),
                        alignment: Alignment.center,
                        child: widget.icon),
                    SizedBox(
                      width: kDefaultPadding / 2,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "${widget.title} \n",
                            style: GoogleFonts.muli(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: TimeAgo.timeAgoSinceDate(widget.time),
                              style: GoogleFonts.muli(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black))
                        ]))
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                widget.content,
                // TitleText(
                //   text: widget.content,
                //   fontSize: 14,
                //   fontWeight: FontWeight.w300,
                //   color: Colors.black,
                // ),
                Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    TitleText(
                      text: widget.isReaded ? "Đã xem" : "Chưa xem",
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ],
            )),
        Positioned(
          right: kDefaultPadding / 2,
          top: kDefaultPadding / 2,
          child: Stack(
            children: [
              Icon(Icons.more_vert),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: PopupMenuButton(
                  onSelected: widget.onSelected,
                  child: Visibility(visible: false, child: Text('')),
                  itemBuilder: widget.isReaded
                      ? (_) => <PopupMenuItem<int>>[
                            new PopupMenuItem<int>(
                                child: new Text('Xóa'), value: 1),
                          ]
                      : (_) => <PopupMenuItem<int>>[
                            new PopupMenuItem<int>(
                                child: new Text('Đã xem'), value: 0),
                            new PopupMenuItem<int>(
                                child: new Text('Xóa'), value: 1),
                          ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
