import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../utils/ui/extensions.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightGrey,
        centerTitle: true,
        title: Text("Gọi Nhanh"),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     height: AppTheme.fullHeight(context),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Container(
      //           height: AppTheme.fullHeight(context) * 0.31,
      //           decoration: BoxDecoration(
      //               shape: BoxShape.rectangle, color: Colors.blueAccent),
      //           child: GoogleMap(
      //             onMapCreated: _onMapCreated,
      //             initialCameraPosition: CameraPosition(
      //               target: _center,
      //               zoom: 11.0,
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           flex: 6,
      //           child: Container(
      //               padding: EdgeInsets.symmetric(
      //                   horizontal: kDefaultPadding / 2,
      //                   vertical: kDefaultPadding / 2),
      //               decoration: BoxDecoration(
      //                   shape: BoxShape.rectangle, color: LightColor.lightGrey),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   TitleText(
      //                     text: "Địa điểm",
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                   TextFormField(
      //                     decoration: InputDecoration(hintText: "Tìm địa chỉ"),
      //                   ),
      //                   SizedBox(
      //                     height: kDefaultPadding / 2,
      //                   ),
      //                   //
      //                   TitleText(
      //                     text: "Dịch vụ",
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                   TextFormField(
      //                     decoration: InputDecoration(
      //                         labelText:
      //                             "Lắp nguyên bộ máy lạnh treo tường 1 - 1.5hp"),
      //                   ),
      //                   SizedBox(
      //                     height: kDefaultPadding / 2,
      //                   ),
      //                   //
      //                   TitleText(
      //                     text: "Số lượng công việc",
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                   TextFormField(
      //                     keyboardType: TextInputType.number,
      //                     decoration:
      //                         InputDecoration(hintText: "Nhập số lượng"),
      //                   ),
      //                   SizedBox(
      //                     height: kDefaultPadding / 2,
      //                   ),
      //                   TitleText(
      //                     text: "Thợ yêu thích",
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                   TextFormField(
      //                     decoration:
      //                         InputDecoration(hintText: "Chọn thợ yêu thích"),
      //                   ),
      //                   SizedBox(
      //                     height: kDefaultPadding / 2,
      //                   ),
      //                 ],
      //               )),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}

class TilteText {}
