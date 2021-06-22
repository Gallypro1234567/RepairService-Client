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
    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: length,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
