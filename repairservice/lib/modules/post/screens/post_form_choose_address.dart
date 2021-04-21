import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../utils/ui/extensions.dart';

class Location extends StatefulWidget {
  final String title;

  const Location({Key key, this.title}) : super(key: key);
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Widget defaultSearch(title, icon) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
      height: AppTheme.fullHeight(context) * .08,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          shape: BoxShape.rectangle,
          color: Colors.white),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: TitleText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Widget historyAddress() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      height: AppTheme.fullHeight(context) * .08,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding / 2,
            ),
            child: Text("Nội Bài -Lào Cai, Sóc Sơn, Hà Nội, Việt Nam"),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: TitleText(
            text: 'Bạn cần cho phép để "RepairSerivce" truy cập vị trí',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TitleText(
                  text: 'Điều này giúp chúng tôi xác định vị trí của bạn',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cho phép'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusColor: LightColor.black,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: LightColor.lightBlue, width: 1.0)),
                      contentPadding: EdgeInsets.only(
                          top: kDefaultPadding / 2, left: kDefaultPadding / 2),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "Nhập 1 tên đường hoặc chọn 1 gợi ý!",
                    ),
                  ),
                
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  defaultSearch("Chọn 1 vị trí trên bản đồ", Icons.map)
                      .ripple(() {})
                      .addNeumorphism(
                        blurRadius: 10,
                        borderRadius: 10,
                        offset: Offset(5, 5),
                        topShadowColor: Colors.white60,
                        bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
                      ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  defaultSearch("Vị trí bạn hiện tại", Icons.location_on)
                      .ripple(() {
                    _showMyDialog();
                  }).addNeumorphism(
                    blurRadius: 10,
                    borderRadius: 10,
                    offset: Offset(5, 5),
                    topShadowColor: Colors.white60,
                    bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      historyAddress().ripple(() {})),
            )
          ],
        ),
      ),
    );
  }
}
