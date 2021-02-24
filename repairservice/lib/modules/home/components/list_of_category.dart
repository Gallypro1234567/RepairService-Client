import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/widgets/item_menu.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({
    Key key,
    @required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  _ListCategoriesState createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kBgDarkColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: widget._size.height * 0.08,
            decoration: BoxDecoration(
                color: Colors.orangeAccent[700],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Center(child: Text('Dịch vụ nổi bật')),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Container(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(10, (index) {
                return ItemMenu();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
