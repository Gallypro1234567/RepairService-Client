import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewChart extends StatelessWidget {
  final double fivePercent;
  final double fourPercent;
  final double threePercent;
  final double twoPercent;
  final double onePercent;
  final double pointRating;
  final int feedbackAmount;

  const ReviewChart({
    Key key,
    this.fivePercent,
    this.fourPercent,
    this.threePercent,
    this.twoPercent,
    this.onePercent,
    this.pointRating,
    this.feedbackAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          text: "Xếp hạng và đánh giá",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleText(
                      text: pointRating.toString().replaceAll('.', ','),
                      fontSize: 60,
                      fontWeight: FontWeight.w500,
                    ),
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (v) {},
                        starCount: 5,
                        rating: pointRating,
                        size: 15,
                        isReadOnly: false,
                        color: Colors.green,
                        borderColor: Colors.grey,
                        spacing: 0),
                    TitleText(
                      text: feedbackAmount.toString(),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: kDefaultPadding / 2,
                  thumbColor: Colors.green,
                  valueIndicatorColor: Colors.green,
                  showValueIndicator: ShowValueIndicator.never,
                  overlayShape: SliderComponentShape.noOverlay,
                  valueIndicatorShape: SliderComponentShape.noOverlay,
                  thumbShape: SliderComponentShape.noOverlay,
                ),
                child: Sliders(
                  five: fivePercent,
                  four: fourPercent,
                  three: threePercent,
                  two: twoPercent,
                  one: onePercent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding * 2,
        ),
      ],
    );
  }
}

class Sliders extends StatelessWidget {
  final double one;
  final double two;
  final double three;
  final double four;
  final double five;
  const Sliders({
    Key key,
    this.one,
    this.two,
    this.three,
    this.four,
    this.five,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            TitleText(
              text: '5',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
              child: Slider(
                value: five,
                onChanged: (val) {},
                min: 0,
                max: 100,
                activeColor: Colors.green[600],
                inactiveColor: Colors.green.shade100,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding / 4,
        ),
        Row(
          children: [
            TitleText(
              text: "4",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
              child: Slider(
                value: four,
                onChanged: (val) {},
                min: 0,
                max: 100,
                activeColor: Colors.green[600],
                inactiveColor: Colors.green.shade100,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding / 4,
        ),
        Row(
          children: [
            TitleText(
              text: "3",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
              child: Slider(
                value: three,
                onChanged: (val) {},
                min: 0,
                max: 100,
                activeColor: Colors.green[600],
                inactiveColor: Colors.green.shade100,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding / 4,
        ),
        Row(
          children: [
            TitleText(
              text: "2",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
              child: Slider(
                value: two,
                onChanged: (val) {},
                min: 0,
                max: 100,
                activeColor: Colors.green[600],
                inactiveColor: Colors.green.shade100,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding / 4,
        ),
        Row(
          children: [
            TitleText(
              text: "1",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
              child: Slider(
                value: one,
                onChanged: (val) {},
                min: 0,
                max: 100,
                activeColor: Colors.green[600],
                inactiveColor: Colors.green.shade100,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
