import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post/screens/post_detail_page.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class CustomerManagerPostContainer extends StatelessWidget {
  final Post post;

  const CustomerManagerPostContainer({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 4,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: AppTheme.fullHeight(context) * 0.2,
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
                              SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 4,
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
                                        color: post.status == 0
                                            ? Colors.lightBlue
                                            : post.status == 1
                                                ? Colors.amber
                                                : post.status == 2
                                                    ? Colors.green
                                                    : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TitleText(
                                      text: post.status == 0
                                          ? "Tin đã đăng"
                                          : post.status == 1
                                              ? "Đang tiếp nhận "
                                              : post.status == 2
                                                  ? "Đã hoàn thành"
                                                  : "đã hủy",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: post.status == 0
                                          ? Colors.white
                                          : post.status == 1
                                              ? Colors.black
                                              : post.status == 2
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

class WorkerManagerPostContainer extends StatelessWidget {
  final Post post;

  const WorkerManagerPostContainer({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 4,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: AppTheme.fullHeight(context) * 0.2,
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
                                        color: post.status == 0
                                            ? Colors.lightBlue
                                            : post.status == 1
                                                ? Colors.amber
                                                : post.status == 2
                                                    ? Colors.green
                                                    : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TitleText(
                                      text: post.status == 0
                                          ? "Tin đã đăng"
                                          : post.status == 1
                                              ? "Đang tiếp nhận "
                                              : post.status == 2
                                                  ? "Đã hoàn thành"
                                                  : "đã hủy",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: post.status == 0
                                          ? Colors.white
                                          : post.status == 1
                                              ? Colors.black
                                              : post.status == 2
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
