import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/modules/home/components/service_container.dart';
import 'package:repairservice/repository/home_repository/models/service_model.dart';

import '../../../utils/ui/extensions.dart';

class ServiceGridview extends StatelessWidget {
  final dynamic size;
  final List<Service> model;

  const ServiceGridview({Key key, this.size, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kBgDarkColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height * 0.08,
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
                crossAxisSpacing: 2,
                children:
                    model.map((e) => ServiceContainer(title: e.name)).toList()),
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
