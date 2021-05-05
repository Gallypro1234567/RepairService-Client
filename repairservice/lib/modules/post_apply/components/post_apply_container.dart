import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PostApplyContainer extends StatelessWidget {
  final WorkerApply postApply;
  final Color backgroundColor;
  final Color textColor;
  const PostApplyContainer({
    Key key,
    this.postApply,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2,
          ),
          height: AppTheme.fullHeight(context) * 0.15,
          decoration: BoxDecoration(color: backgroundColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.all(
                    kDefaultPadding / 4,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: postApply.imageUrl != null
                              ? postApply.imageUrl.isNotEmpty
                                  ? NetworkImage(postApply.imageUrl)
                                  : AssetImage(
                                      "assets/images/user_profile_background.jpg")
                              : AssetImage(
                                  "assets/images/user_profile_background.jpg")))),
              SizedBox(
                width: kDefaultPadding / 2,
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
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
        ),
        Positioned(
          top: kDefaultPadding,
          right: kDefaultPadding / 2,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                //color: LightColor.lightGrey,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 1)),
            child: Icon(
              Icons.check,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
