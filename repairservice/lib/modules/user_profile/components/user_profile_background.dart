import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/user_profile/components/user_profile_scrollview.dart';
import 'package:repairservice/widgets/title_text.dart';

class UserProfileBackground extends StatelessWidget {
  final Widget child;

  const UserProfileBackground({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: kDefaultPadding * 1.5,
          left: 0,
          child: Container(
            width: AppTheme.fullWidth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: TitleText(
                      text: "Tài khoản",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
