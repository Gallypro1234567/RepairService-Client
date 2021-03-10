import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ABC extends StatefulWidget {
  @override
  _ABCState createState() => _ABCState();
}

class _ABCState extends State<ABC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết"),
        ),
        body: Container(child: Text("ABC")));
  }
}
