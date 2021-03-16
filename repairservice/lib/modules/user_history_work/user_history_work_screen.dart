import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserHistoryWork extends StatefulWidget {
  final String title;
  final String id;
  const UserHistoryWork({Key key, this.title, this.id}) : super(key: key);

  @override
  _UserHistoryWorkState createState() => _UserHistoryWorkState();
}

class _UserHistoryWorkState extends State<UserHistoryWork> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            child: Text("Trang ${widget.title}"),
          ),
        ),
      ),
    );
  }
}
