import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/modules/home/models/home_category_model.dart';
import 'package:repairservice/modules/home_work_categories/item_work_categories_card.dart';
import '../../utils/ui/extensions.dart';

class ListWorkCategories extends StatefulWidget {
  const ListWorkCategories({
    Key key,
    @required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  _ListWorkCategoriesState createState() => _ListWorkCategoriesState();
}

class _ListWorkCategoriesState extends State<ListWorkCategories> {
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
                color: Colors.orange[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Center(child: Text('Dịch vụ nổi bật ')),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Container(
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: workCategories
                    .map((e) => ItemWorkCategories(title: e.name))
                    .toList()),
          ),
        ],
      ),
    ).addNeumorphism(
      blurRadius: 10,
      borderRadius: 10,
      offset: Offset(5, 5),
      topShadowColor: Colors.white60,
      bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
    );
  }
}
