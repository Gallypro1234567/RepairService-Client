import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/schedule_to_repair/schedule_form.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../utils/ui/extensions.dart';

class WorkCategoriesDetail extends StatefulWidget {
  final String title;

  const WorkCategoriesDetail({Key key, this.title}) : super(key: key);
  @override
  _WorkCategoriesDetailState createState() => _WorkCategoriesDetailState();
}

class _WorkCategoriesDetailState extends State<WorkCategoriesDetail> {
  Widget _listWork() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        height: AppTheme.fullHeight(context) * 0.14,
        decoration: BoxDecoration(
            border: Border.all(color: LightColor.lightblack, width: 0.1),
            color: LightColor.lightGrey,
            shape: BoxShape.rectangle),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/man.png"),
              ),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
                child: TitleText(
              text: "Lắp nguyên bộ máy lạnh treo tường 1 - 1.5hp",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
          ],
        ),
      ).ripple(() {
        Navigator.push(context, SlideFadeRoute(page: ScheduleScreen()));
        // Navigator.of(context, rootNavigator: true).push(
        //   new CupertinoPageRoute(
        //     builder: (c) {
        //       return new ScheduleScreen();
        //     },
        //   ),
        // );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: LightColor.lightGrey,
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding),
          height: AppTheme.fullHeight(context),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: LightColor.lightGrey,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusColor: LightColor.grey,
                  contentPadding: EdgeInsets.only(top: kDefaultPadding / 2),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Bạn cần tìm dịch vụ gì ?",
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) => _listWork(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
