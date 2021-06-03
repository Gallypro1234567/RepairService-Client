// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:repairservice/config/themes/constants.dart';
// import 'package:repairservice/config/themes/light_theme.dart';
// import 'package:repairservice/config/themes/theme_config.dart';
// import 'package:repairservice/modules/splash/splash_page.dart';
// import 'package:repairservice/repository/post_repository/models/time_ago.dart';
// import 'package:repairservice/widgets/title_text.dart';
// import 'package:vertical_tabs/vertical_tabs.dart';

// import 'bloc/notification_bloc.dart';

// class NotificationScreen extends StatefulWidget {
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: AppTheme.fullHeight(context) * .06,
//         title: TitleText(
//           text: "Thông báo",
//           fontSize: 22,
//           fontWeight: FontWeight.w600,
//           color: Colors.white,
//         ),
//         centerTitle: false,
//         backgroundColor: LightColor.lightteal,
//       ),
//       body: VerticalTabs(
//         tabsWidth: AppTheme.fullWidth(context) * .15,
//         backgroundColor: LightColor.lightGrey,
//         selectedTabBackgroundColor: Colors.white,
//         tabBackgroundColor: LightColor.lightGrey,
//         indicatorColor: LightColor.lightteal,
//         tabs: <Tab>[
//           Tab(
//               child: Center(
//             child: Stack(
//               children: [
//                 Icon(
//                   Icons.home,
//                   size: 40,
//                 ),
//                 Positioned(
//                   right: 0,
//                   child: Container(
//                     height: 10,
//                     width: 10,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: Colors.red),
//                   ),
//                 )
//               ],
//             ),
//           )),
//           Tab(
//               child: Center(
//             child: Stack(
//               children: [
//                 Icon(
//                   Icons.list_alt,
//                   size: 40,
//                 ),
//                 Positioned(
//                   right: 0,
//                   child: Container(
//                     height: 10,
//                     width: 10,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: Colors.red),
//                   ),
//                 )
//               ],
//             ),
//           )),
//           Tab(
//               child: Center(
//             child: Stack(
//               children: [
//                 Icon(
//                   Icons.person,
//                   size: 40,
//                 ),
//                 Positioned(
//                   right: 0,
//                   child: Container(
//                     height: 10,
//                     width: 10,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: Colors.red),
//                   ),
//                 )
//               ],
//             ),
//           )),
//         ],
//         contents: <Widget>[
//           BlocListener<NotificationBloc, NotificationState>(
//             listener: (context, state) {
//               if (state.status == NotificationStatus.none)
//                 context.read<NotificationBloc>().add(NotificationFetched());
//               if (state.status == NotificationStatus.submittedSuccess)
//                 context.read<NotificationBloc>().add(NotificationRefeshed(-1));
//             },
//             child: BlocBuilder<NotificationBloc, NotificationState>(
//               builder: (context, state) {
//                 switch (state.status) {
//                   case NotificationStatus.loading:
//                     return SplashPage();
//                     break;
//                   case NotificationStatus.failure:
//                     return Center(
//                       child: Text("Lỗi"),
//                     );
//                   default:
//                     return RefreshIndicator(
//                       onRefresh: () async {
//                         context
//                             .read<NotificationBloc>()
//                             .add(NotificationFetched());
//                       },
//                       child: AnimatedList(
//                         initialItemCount: state.notifications.length, 
//                         itemBuilder: (context, index, animation) =>
//                             SlideTransition(
//                           position: animation.drive(Tween(
//                               begin: Offset(2, 0.0), end: Offset(0.0, 0.0))),
//                           child: NotifiContainer(
//                             title: state.notifications[index].title,
//                             content: state.notifications[index].content,
//                             time: state.notifications[index].createAt,
//                             isReaded: state.notifications[index].isReaded == 0
//                                 ? false
//                                 : true,
//                             onSelected: (val) {
//                               context.read<NotificationBloc>().add(
//                                   NotificationSubmitted(
//                                       code: state.notifications[index].code,
//                                       type: val));
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//                 }
//               },
//             ),
//           ),
//           Container(
//               // child: ListView.builder(
//               //   itemCount: state.notifications.length,
//               //   itemBuilder: (context, index) => Padding(
//               //     padding: const EdgeInsets.only(top: kDefaultPadding / 8),
//               //     child: NotifiContainer(
//               //       title: state.notifications[index].title,
//               //       content: state.notifications[index].content,
//               //       time: state.notifications[index].createAt,
//               //       isReaded:
//               //           state.notifications[index].isReaded == 0 ? false : true,
//               //       onSelected: (val) {
//               //         context.read<NotificationBloc>().add(NotificationSubmitted(
//               //             code: state.notifications[index].code, type: val));
//               //       },
//               //     ),
//               //   ),
//               // ),
//               ),
//           Container()
//         ],
//       ),
//     );
//   }
// }

// class NotifiContainer extends StatefulWidget {
//   final String title;
//   final String time;
//   final String content;
//   final bool ofme;
//   final bool isReaded;
//   final Function(int) onSelected;

//   const NotifiContainer({
//     Key key,
//     this.title,
//     this.time,
//     this.content,
//     this.ofme = true,
//     this.isReaded = false,
//     this.onSelected,
//   }) : super(key: key);

//   @override
//   State<NotifiContainer> createState() => _NotifiContainerState();
// }

// class _NotifiContainerState extends State<NotifiContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AnimatedContainer(
//             curve: Curves.fastOutSlowIn,
//             duration: Duration(microseconds: 500),
//             padding: EdgeInsets.symmetric(
//                 vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
//             decoration: BoxDecoration(
//               color: widget.isReaded ? Colors.white : Colors.green[50],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                         padding: EdgeInsets.all(kDefaultPadding / 4),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: widget.ofme
//                                 ? Colors.blue[400]
//                                 : Colors.red[400]),
//                         alignment: Alignment.center,
//                         child: Icon(
//                           widget.ofme ? Icons.list_alt : Icons.history,
//                           color: Colors.white,
//                         )),
//                     SizedBox(
//                       width: kDefaultPadding / 2,
//                     ),
//                     RichText(
//                         text: TextSpan(
//                             text: "${widget.title} \n",
//                             style: GoogleFonts.muli(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                             children: [
//                           TextSpan(
//                               text: TimeAgo.timeAgoSinceDate(widget.time),
//                               style: GoogleFonts.muli(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.black))
//                         ]))
//                   ],
//                 ),
//                 SizedBox(
//                   height: kDefaultPadding / 2,
//                 ),
//                 TitleText(
//                   text: widget.content,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.black,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(),
//                     ),
//                     TitleText(
//                       text: widget.isReaded ? "Đã xem" : "Chưa xem",
//                       fontSize: 10,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ],
//                 ),
//               ],
//             )),
//         Positioned(
//           right: kDefaultPadding / 2,
//           top: kDefaultPadding / 2,
//           child: Stack(
//             children: [
//               Icon(Icons.more_vert),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: PopupMenuButton(
//                   onSelected: widget.onSelected,
//                   child: Visibility(visible: false, child: Text('')),
//                   itemBuilder: widget.isReaded
//                       ? (_) => <PopupMenuItem<int>>[
//                             new PopupMenuItem<int>(
//                                 child: new Text('Xóa'), value: 1),
//                           ]
//                       : (_) => <PopupMenuItem<int>>[
//                             new PopupMenuItem<int>(
//                                 child: new Text('Đã xem'), value: 0),
//                             new PopupMenuItem<int>(
//                                 child: new Text('Xóa'), value: 1),
//                           ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
