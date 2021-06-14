import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarContainer extends StatelessWidget {
  final String imageUrl;
  const AvatarContainer({
    Key key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      // colorFilter: ColorFilter.mode(
                      //     Colors.red, BlendMode.colorBurn)
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/user_profile_background.jpg"))
        : CircleAvatar(
            backgroundImage:
                AssetImage("assets/images/user_profile_background.jpg"));
  }
}
