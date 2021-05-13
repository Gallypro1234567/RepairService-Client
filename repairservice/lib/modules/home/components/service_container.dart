import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post/bloc/post_bloc.dart';
import 'package:repairservice/modules/post_get_list/post_get_list_page.dart'; 
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

class ServiceContainer extends StatelessWidget {
  final String title;
  final String imageUrl;
  const ServiceContainer({Key key, this.title, this.imageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: AppTheme.fullHeight(context) * 0.4,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor:
                        imageUrl != null ? Colors.transparent : null,
                    backgroundImage:
                        imageUrl != null ? NetworkImage(imageUrl) : null,
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Expanded(
                flex: 1,
                child: TitleText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    SlideFadeRoute(
                        page: PostOfServicePage(
                      title: title,
                    )));
              },
            );
          },
        ),
      ],
    ); 
  }
}
