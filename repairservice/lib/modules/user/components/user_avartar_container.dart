import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';

class UserAvartarContainer extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String phone;
  const UserAvartarContainer({Key key, this.title, this.imageUrl, this.phone})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      width: AppTheme.fullWidth(context),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: kBgDarkColor),
      child: Row(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : AssetImage("assets/images/user_profile_background.jpg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text.rich(
              TextSpan(
                text: "${title.toUpperCase()} \n",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: '${phone.toUpperCase()} \n',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_right, color: Colors.black),
        ],
      ),
    );
  }
}
class UserAvartarContainers extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String phone;
  const UserAvartarContainers({Key key, this.title, this.imageUrl, this.phone})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      width: AppTheme.fullWidth(context),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: kBgDarkColor),
      child: Row(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : AssetImage("assets/images/user_profile_background.jpg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text.rich(
              TextSpan(
                text: "${title.toUpperCase()} \n",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: '${phone.toUpperCase()} \n',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_right, color: Colors.black),
        ],
      ),
    );
  }
}
