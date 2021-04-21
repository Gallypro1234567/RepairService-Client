import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';

class PostofWorkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightGrey,
        centerTitle: true,
        title: Text("Danh sách Đơn thực hiện"),
      ),
      body: Center(
        child: Text("List Post"),
      ),
    );
  }
}
