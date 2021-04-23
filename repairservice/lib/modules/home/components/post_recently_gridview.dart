import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';

import 'package:repairservice/modules/post/components/post_item_container.dart';
import 'package:repairservice/modules/post/screens/post_detail_page.dart';

import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../utils/ui/extensions.dart';

class PostRecenttlyGridview extends StatelessWidget {
  final ScrollController scrollController;
  final List<Post> posts;
  final int length;
  final Function(BuildContext, int) itemBuilder;
  const PostRecenttlyGridview(
      {Key key, this.posts, this.scrollController, this.length, this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            height: kDefaultPadding * 2,
            padding: EdgeInsets.only(left: kDefaultPadding / 2),
            alignment: Alignment.centerLeft,
            child: TitleText(
              text: "Tin đăng gần đây",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: itemBuilder,
          ),
        ],
      ),
    );
  }
}
