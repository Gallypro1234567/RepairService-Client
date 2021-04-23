import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/manager/components/manager_post_item_container.dart';

import 'package:repairservice/modules/splash/splash_page.dart';

class ManagerGridViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) {
        switch (state.pageStatus) {
          case PageStatus.loading:
            return SplashPage();
          case PageStatus.success:
            return Container(
              color: LightColor.lightGrey,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.posts.length,
                itemBuilder: (context, index) => ManagerPostContainer(
                  post: state.posts[index],
                ),
              ),
            );
            break;
          default:
            return SplashPage();
        }
      },
    );
  }
}
