import 'package:flutter/cupertino.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/home/components/preferentail_container.dart';
import 'package:repairservice/repository/home_repository/models/preferential_model.dart';
import '../../../utils/ui/extensions.dart';

class PreferentialHorizontalView extends StatelessWidget {
  final HomeState state;
  final List<Preferential> model;

  const PreferentialHorizontalView({Key key, this.model, this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .8,
      color: LightColor.lightGrey,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, mainAxisSpacing: 30, crossAxisSpacing: 20),
        scrollDirection: Axis.horizontal,
        children: model
            .map(
              (obj) => Padding(
                padding: EdgeInsets.only(
                    top: kDefaultPadding / 2, bottom: kDefaultPadding / 2),
                child: PreferentialContainer(
                  model: obj,
                ).ripple(() {},
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            )
            .toList(),
      ),
    );
  }
}
