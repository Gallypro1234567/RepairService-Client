import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ABC extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ABC());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Home"),
      ),
    );
  }
}
