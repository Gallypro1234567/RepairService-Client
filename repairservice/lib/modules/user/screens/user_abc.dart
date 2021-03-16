import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ABC extends StatefulWidget {
  final String title;

  const ABC({Key key, this.title}) : super(key: key);

  @override
  _ABCState createState() => _ABCState();
}

class _ABCState extends State<ABC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: Container(child: Text("Trang ${widget.title}"))));
  }
}
