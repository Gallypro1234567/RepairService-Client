import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:repairservice/config/themes/theme_config.dart';

class GoogleMapContainer extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;
  final LatLng center;
  const GoogleMapContainer({Key key, this.onMapCreated, this.center})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.fullHeight(context) * 0.34,
      decoration:
          BoxDecoration(shape: BoxShape.rectangle, color: Colors.blueAccent),
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
