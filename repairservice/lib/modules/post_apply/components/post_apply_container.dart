import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PostApplyContainer extends StatelessWidget {
  final WorkerApply postApply;
  final Color backgroundColor;
  final Color textColor;
  final int status;
  final int postStatus;
  final List<BoxShadow> boxShadows;
  const PostApplyContainer({
    Key key,
    this.postApply,
    this.backgroundColor,
    this.textColor,
    this.status,
    this.postStatus,
    this.boxShadows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
      ),
      height: Responsive.isTablet(context)
          ? AppTheme.fullHeight(context) * .4
          : AppTheme.fullHeight(context) * 0.15,
      foregroundDecoration: RotatedCornerDecoration(
        color: status != 1
            ? status != 2
                ? status != 3
                    ? Colors.red
                    : Colors.blue
                : Colors.green
            : postStatus >= 1
                ? Colors.grey
                : Colors.amber,
        geometry: BadgeGeometry(width: 70, height: 70),
        textSpan: TextSpan(
          text: status != 1
              ? status != 2
                  ? status != 3
                      ? "Đã hủy"
                      : "Đã Check In"
                  : "Được chọn"
              : postStatus >= 1
                  ? "Đã qua"
                  : "Đang đợi",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: status != 1
                  ? status != 2
                      ? status != 3
                          ? Colors.white
                          : Colors.white
                      : Colors.white
                  : postStatus == 1
                      ? Colors.white
                      : Colors.black),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: boxShadows,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.all(
              kDefaultPadding / 4,
            ),
            child: postApply.imageUrl == null
                ? Image.asset("assets/images/user_profile_background.jpg")
                : CachedNetworkImage(
                    imageUrl: postApply.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                            RichText(
                              text: TextSpan(
                                text: 'Nhân viên: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: textColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${postApply.fullname}',
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
                                text: 'SDT: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: textColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${postApply.phone}',
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
                                text: 'Nghề nghiệp: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: textColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${postApply.serviceName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: kDefaultPadding / 4,
                            ),
                            SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {},
                                starCount: 5,
                                rating: postApply.pointFeedback,
                                size: 20.0,
                                isReadOnly: true,
                                color: Colors.green,
                                borderColor: Colors.green,
                                spacing: 0.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                TitleText(
                                  text: TimeAgo.timeAgoSinceDate(
                                      postApply.createAt),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class PostApplyDisableContainer extends StatelessWidget {
  final WorkerApply postApply;
  final Color backgroundColor;
  final Color textColor;
  final int status;
  final int postStatus;
  const PostApplyDisableContainer({
    Key key,
    this.postApply,
    this.backgroundColor,
    this.textColor,
    this.status,
    this.postStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
      ),
      height: Responsive.isTablet(context)
          ? AppTheme.fullHeight(context) * .4
          : AppTheme.fullHeight(context) * 0.15,
      foregroundDecoration: const RotatedCornerDecoration(
        color: Colors.red,
        geometry: const BadgeGeometry(width: 64, height: 64),
        textSpan: const TextSpan(
          text: ' Đã hủy',
          style: TextStyle(fontSize: 14),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.all(
              kDefaultPadding / 4,
            ),
            child: postApply.imageUrl == null
                ? Image.asset("assets/images/user_profile_background.jpg")
                : CachedNetworkImage(
                    imageUrl: postApply.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                            RichText(
                              text: TextSpan(
                                text: 'Nhân viên: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: textColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${postApply.fullname}',
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
                                text: 'SDT: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: textColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${postApply.phone}',
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
                                text: 'Nghề nghiệp: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: textColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${postApply.serviceName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: kDefaultPadding / 4,
                            ),
                            SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {},
                                starCount: 5,
                                rating: 3,
                                size: 20.0,
                                isReadOnly: true,
                                color: Colors.green,
                                borderColor: Colors.green,
                                spacing: 0.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                TitleText(
                                  text: TimeAgo.timeAgoSinceDate(
                                      postApply.createAt),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
