import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart'; 

class PostApplyGridView extends StatelessWidget {

  final int length;
  final Function(BuildContext, int) itemBuilder;

  const PostApplyGridView({Key key, this.length, this.itemBuilder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container(
          //   color: Colors.white,
          //   height: kDefaultPadding * 2,
          //   padding: EdgeInsets.only(left: kDefaultPadding / 2),
          //   alignment: Alignment.centerLeft,
          //   child: TitleText(
          //     text: "Tin đăng gần đây",
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          ListView.builder(
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
