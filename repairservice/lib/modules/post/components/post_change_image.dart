import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/widgets/title_text.dart';

class PostChangedImage extends StatelessWidget {
  final double height;
  final double width;
  final double iconsize;
  const PostChangedImage({
    Key key,
    this.height,
    this.width,
    this.iconsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [5, 5],
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      child: Container(
          padding: EdgeInsets.only(
            top: kDefaultPadding,
          ),
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.amber,
                size: iconsize,
              ),
              TitleText(
                text: "Chọn ảnh",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )
            ],
          )),
    );
  }
}
