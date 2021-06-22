import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CommentsContainer extends StatelessWidget {
  final String fullName;
  final String createAt;
  final String description;
  final double pointRating;
  final String imageUrl;
  const CommentsContainer({
    Key key,
    this.fullName,
    this.createAt,
    this.description,
    this.pointRating,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            imageUrl.isNotEmpty
                ? CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(
                            //     Colors.red, BlendMode.colorBurn),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/user_profile_background.jpg"),
                  ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
              child: TitleText(
                text: fullName,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding / 4,
        ),
        Row(
          children: [
            SmoothStarRating(
                allowHalfRating: false,
                onRated: null,
                starCount: 5,
                rating: pointRating,
                size: 20,
                isReadOnly: true,
                color: Colors.green,
                borderColor: Colors.grey,
                spacing: 0),
            SizedBox(
              width: kDefaultPadding / 4,
            ),
            Expanded(
              child: TitleText(
                text: createAt,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 4),
          child: Row(
            children: [
              Expanded(
                child: TitleText(
                  text: description,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
      ],
    );
  }
}
