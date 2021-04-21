import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/modules/post_find_worker/post_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'components/item_post_container.dart';

class WorkCategoriesDetail extends StatefulWidget {
  final String title;

  const WorkCategoriesDetail({Key key, this.title}) : super(key: key);
  @override
  _WorkCategoriesDetailState createState() => _WorkCategoriesDetailState();
}

class _WorkCategoriesDetailState extends State<WorkCategoriesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.lightGrey,
      appBar: AppBar(
        backgroundColor: LightColor.lightteal,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: TextFormField(
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
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => ItemPostContainer(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColor.lightteal,
        onPressed: () {
          Navigator.push(context, SlideFadeRoute(page: PostPage()));
        },
        child: Center(child: Icon(Entypo.plus)),
      ),
    );
  }
}
