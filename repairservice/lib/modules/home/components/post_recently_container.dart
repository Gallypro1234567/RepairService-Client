import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';

import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/widgets/title_text.dart';

class PostRecentlyContainer extends StatelessWidget {
  final Post post;

  const PostRecentlyContainer({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kDefaultPadding / 6,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: AppTheme.fullHeight(context) * 0.15,
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
                  // image: post.imageUrl == null
                  //     ? DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: AssetImage("assets/images/default.jpg"))
                  //     : DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: NetworkImage(post.imageUrl))
                ),
                child: CachedNetworkImage(
                  imageUrl: post.imageUrl == null ? "assets/images/default.jpg":  post.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(
                        //     Colors.red, BlendMode.colorBurn),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(child:  Image.asset("assets/images/loading2.gif")),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
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
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: kDefaultPadding / 4),
                        child: TitleText(
                          text: post.title,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: kDefaultPadding / 4),
                        child: RichText(
                          text: TextSpan(
                            text: 'Danh mục: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${post.serviceText == null ? "" : post.serviceText}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
