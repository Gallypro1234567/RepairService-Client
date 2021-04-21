import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post/screens/post_form_choose_address.dart';

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';
import '../components/post_google_map_container.dart';

class PostFindWorkerPage extends StatefulWidget {
  @override
  _PostFindWorkerPageState createState() => _PostFindWorkerPageState();
}

class _PostFindWorkerPageState extends State<PostFindWorkerPage> {
  GoogleMapController mapController;
  bool _checked = false;

  final LatLng _center = const LatLng(10.046814011014613, 105.76778568212151);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _checked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightGrey,
        centerTitle: true,
        title: Text("Gọi Nhanh"),
      ),
      body: ListView(
        children: [
          GoogleMapContainer(
            onMapCreated: _onMapCreated,
            center: _center,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: "Địa điểm",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Tìm địa chỉ",
                      contentPadding:
                          EdgeInsets.only(left: kDefaultPadding / 2)),
                ).ripple(() {
                  Navigator.push(
                      context,
                      SlideFadeRoute(
                          page: Location(
                        title: "Chọn địa điểm",
                      )));
                }),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),

                //
                TitleText(
                  text: "Dịch vụ",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Lắp nguyên bộ máy lạnh treo tường 1 - 1.5hp",
                      hintStyle: TextStyle(fontWeight: FontWeight.w500),
                      contentPadding:
                          EdgeInsets.only(left: kDefaultPadding / 2)),
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                //
                TitleText(
                  text: "Số lượng công việc",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Nhập số lượng",
                      contentPadding:
                          EdgeInsets.only(left: kDefaultPadding / 2)),
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                TitleText(
                  text: "Thợ yêu thích",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Chọn thợ yêu thích",
                      contentPadding:
                          EdgeInsets.only(left: kDefaultPadding / 2)),
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Container(
                  height: AppTheme.fullHeight(context) * 0.1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                text: "Ngày bắt đầu",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "dd/mm/yyyy",
                                    contentPadding: EdgeInsets.only(
                                        left: kDefaultPadding / 2)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                text: "Giờ bắt đầu",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "hh:mm",
                                    contentPadding: EdgeInsets.only(
                                        left: kDefaultPadding / 2)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        height: AppTheme.fullHeight(context) * 0.2,
        decoration:
            BoxDecoration(color: Colors.white, shape: BoxShape.rectangle),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.rectangle),
                      child: Center(
                        child: CheckboxListTile(
                          title: TitleText(
                            text: "Gọi nhanh",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          value: _checked,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool value) {
                            setState(() {
                              _checked = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.rectangle),
                      child: Center(
                        child: CheckboxListTile(
                          title: TitleText(
                            text: "Đặt lịch",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          value: _checked,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool value) {
                            setState(() {
                              _checked = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: LightColor.lightblack,
                      shape: BoxShape.rectangle),
                  child: Center(
                      child: TitleText(
                          text: "Tiếp tục",
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ).ripple(
                  () {},
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TilteText {}
