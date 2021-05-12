import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';

class WorkerInfoContainer extends StatelessWidget {
  final ImageProvider<Object> imageUrl;
  final String fullname;
  final String phone;
  final String wofsText;
  const WorkerInfoContainer({
    Key key,
    this.imageUrl,
    this.fullname,
    this.phone,
    this.wofsText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: imageUrl,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: fullname,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: kDefaultPadding / 4,
              ),
              RichText(
                  text: TextSpan(
                      text: "SĐT: ",
                      style: TextStyle(
                          color: LightColor.black,
                          fontWeight: FontWeight.normal),
                      children: [TextSpan(text: phone)])),
              SizedBox(
                height: kDefaultPadding / 4,
              ),
              RichText(
                  text: TextSpan(
                      text: "Nghề nghiệp: ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      children: [TextSpan(text: wofsText)])),
            ],
          )
        ],
      ),
    );
  }
}
