import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import '../../utils/ui/extensions.dart';

class WorkCategoriesDetail extends StatefulWidget {
  final String title;

  const WorkCategoriesDetail({Key key, this.title}) : super(key: key);
  @override
  _WorkCategoriesDetailState createState() => _WorkCategoriesDetailState();
}

class _WorkCategoriesDetailState extends State<WorkCategoriesDetail> {
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
                  focusColor: LightColor.grey,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
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
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      height: AppTheme.fullHeight(context) * 0.14,
                      decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.grey
                              : Colors.orangeAccent,
                          shape: BoxShape.rectangle),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                          Expanded(child: Text(widget.title)),
                        ],
                      ),
                    ).ripple(() {}),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
