import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';

class ItemMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/icon_repairman.png"),
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Text.rich(TextSpan(
              text: "Thợ sửa nước",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              )))
        ],
      ),
    );
  }
}
