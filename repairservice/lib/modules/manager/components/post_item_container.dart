import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';

import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';

import 'package:repairservice/widgets/title_text.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class CustomerManagerPostContainer extends StatelessWidget {
  final Post post;

  const CustomerManagerPostContainer({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 6,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: AppTheme.fullHeight(context) * 0.2,
        foregroundDecoration: RotatedCornerDecoration(
          color: post.status == 0
              ? Colors.amber
              : post.status != 1
                  ? post.status != 2
                      ? post.status != 3
                          ? Colors.blue
                          : Colors.red
                      : post.feedbackAmount == 0
                          ? Colors.pink
                          : Colors.green
                  : Colors.green,
          geometry: BadgeGeometry(width: 124, height: 64),
          textSpan: TextSpan(
            text: post.status == 0
                ? "Tin đã đăng"
                : post.status != 1
                    ? post.status != 2
                        ? post.status != 3
                            ? "Đã hoàn thành"
                            : "Đã hủy"
                        : post.feedbackAmount == 0
                            ? "Chưa đánh giá"
                            : "Đã hoàn thành"
                    : "Bạn đã chấp nhận",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: post.status == 0
                  ? Colors.white
                  : post.status != 1
                      ? post.status != 2
                          ? post.status != 3
                              ? Colors.white
                              : Colors.white
                          : Colors.white
                      : Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(
                  kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: post.imageUrl == null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/default.jpg"))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(post.imageUrl))),
              ),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TitleText(
                                  text: post.title == null ? "" : post.title,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              Row(
                                children: [
                                  // TitleText(
                                  //   text: "Danh mục: ",
                                  //   fontSize: 14,
                                  //   fontWeight: FontWeight.normal,
                                  // ),
                                  TitleText(
                                    text: post.serviceText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              // SizedBox(
                              //   height: kDefaultPadding / 4,
                              // ),
                              // SizedBox(
                              //   height: kDefaultPadding / 4,
                              // ),
                              Row(
                                children: [
                                  // TitleText(
                                  //   text: "Trạng thái: ",
                                  //   fontSize: 14,
                                  //   fontWeight: FontWeight.normal,
                                  // ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: kDefaultPadding / 4,
                                        horizontal: kDefaultPadding / 4),
                                    decoration: BoxDecoration(
                                        color: post.status == 0
                                            ? Colors.amber
                                            : post.status != 1
                                                ? post.status != 2
                                                    ? post.status != 3
                                                        ? Colors.blue
                                                        : Colors.red
                                                    : post.feedbackAmount == 0
                                                        ? Colors.pink
                                                        : Colors.green
                                                : Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TitleText(
                                      text: post.status == 0
                                          ? "Tin đã đăng"
                                          : post.status != 1
                                              ? post.status != 2
                                                  ? post.status != 3
                                                      ? "Đã hoàn thành"
                                                      : "Đã hủy"
                                                  : post.feedbackAmount == 0
                                                      ? "Chưa đánh giá"
                                                      : "Đã hoàn thành"
                                              : "Bạn đã chấp nhận",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: post.status == 0
                                          ? Colors.black
                                          : post.status != 1
                                              ? post.status != 2
                                                  ? post.status != 3
                                                      ? Colors.white
                                                      : Colors.white
                                                  : post.feedbackAmount == 0
                                                      ? Colors.white
                                                      : Colors.white
                                              : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                          TitleText(
                            text: post.address == null ? "" : post.address,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: Container()),
                          TitleText(
                            text: TimeAgo.timeAgoSinceDate(post.createAt),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class WorkerManagerPostContainer extends StatelessWidget {
  final Post post;

  const WorkerManagerPostContainer({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 6,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: AppTheme.fullHeight(context) * 0.2,
        foregroundDecoration: RotatedCornerDecoration(
          color: post.applystatus == 1
              ? Colors.amber
              : post.applystatus == 2
                  ? Colors.green
                  : post.applystatus == 3
                      ? post.feedbackAmount == 1
                          ? Colors.green
                          : Colors.blue
                      : Colors.red,
          geometry: BadgeGeometry(width: 124, height: 64),
          textSpan: TextSpan(
            text: post.applystatus == 1
                ? "Đang chờ"
                : post.applystatus == 2
                    ? "Đã chấp nhận"
                    : post.applystatus == 3
                        ? post.feedbackAmount == 1
                            ? "Đã hoàn thành"
                            : "Đã Check In"
                        : "đã hủy",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: post.applystatus == 1
                    ? Colors.white
                    : post.applystatus == 2
                        ? Colors.white
                        : post.applystatus == 3
                            ? Colors.white
                            : Colors.white),
          ),
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(
                  kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: post.imageUrl == null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/default.jpg"))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(post.imageUrl))),
              ),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TitleText(
                                  text: post.title == null ? "" : post.title,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Khách hàng: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${post.fullname == null ? "" : post.fullname}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'SĐT: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${post.phone == null ? "" : post.phone}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Chú ý: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Chưa check in',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              Row(
                                children: [
                                  TitleText(
                                    text: "Trạng thái: ",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: kDefaultPadding / 4,
                                        horizontal: kDefaultPadding / 4),
                                    decoration: BoxDecoration(
                                        color: post.applystatus == 1
                                            ? Colors.amber
                                            : post.applystatus == 2
                                                ? Colors.green
                                                : post.applystatus == 3
                                                    ? post.feedbackAmount == 1
                                                        ? Colors.green
                                                        : Colors.blue
                                                    : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TitleText(
                                      text: post.applystatus == 1
                                          ? "Đang chờ"
                                          : post.applystatus == 2
                                              ? "Khách hàng chấp nhận"
                                              : post.applystatus == 3
                                                  ? post.feedbackAmount == 1
                                                      ? "Đã hoàn thành"
                                                      : "Đã Check In"
                                                  : "đã hủy",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: post.applystatus == 1
                                          ? Colors.white
                                          : post.applystatus == 2
                                              ? Colors.white
                                              : post.applystatus == 3
                                                  ? Colors.white
                                                  : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                          TitleText(
                            text: post.address == null ? "" : post.address,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: Container()),
                          TitleText(
                            text: TimeAgo.timeAgoSinceDate(post.createAt),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class WorkerManagerPostDisableContainer extends StatelessWidget {
  final Post post;

  const WorkerManagerPostDisableContainer({Key key, this.post})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 6,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: AppTheme.fullHeight(context) * 0.2,
        foregroundDecoration: RotatedCornerDecoration(
          color: Colors.red,
          geometry: BadgeGeometry(width: 70, height: 70),
          textSpan: TextSpan(
            text: "Đã hủy",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(color: Colors.white54),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(
                  kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: post.imageUrl == null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/default.jpg"))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(post.imageUrl))),
              ),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TitleText(
                                  text: post.title == null ? "" : post.title,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Khách hàng: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${post.fullname == null ? "" : post.fullname}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'SĐT: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${post.phone == null ? "" : post.phone}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Chú ý: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Chưa check in',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                          TitleText(
                            text: post.address == null ? "" : post.address,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: Container()),
                          TitleText(
                            text: TimeAgo.timeAgoSinceDate(post.createAt),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
