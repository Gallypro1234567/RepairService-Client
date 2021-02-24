import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemNewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * 0.2,
      color: Colors.purple,
      width: _size.width * 0.4,
      child: Text('ABC'),
    );
  }
}
