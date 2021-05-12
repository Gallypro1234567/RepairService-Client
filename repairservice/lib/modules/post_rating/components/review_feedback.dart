import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';

class ReviewFeedBack extends StatelessWidget {
  final int amount;
  final int customerAmount;
  final double avgPointRating;
  final int finishAmount;
  final int cancelAmount;
  const ReviewFeedBack({
    Key key,
    this.avgPointRating,
    this.amount,
    this.customerAmount,
    this.finishAmount,
    this.cancelAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: avgPointRating.toString(),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.green,
                    )
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: customerAmount.toString(),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    TitleText(
                      text: " bài đánh giá",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              ],
            ),
          )),
          Container(
            height: AppTheme.fullHeight(context) * 0.03,
            width: 1,
            color: Colors.grey,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: "$finishAmount /",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    TitleText(
                      text: " $amount",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: "Hoàn thành",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              ],
            ),
          )),
          Container(
            height: AppTheme.fullHeight(context) * 0.03,
            width: 1,
            color: Colors.grey,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: "$cancelAmount /",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    TitleText(
                      text: " $amount",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: "Hủy",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
