import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post_update/bloc/postupdate_bloc.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class PostUpdateSelectCityPage extends StatelessWidget {
  final Function onPressed;

  const PostUpdateSelectCityPage({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: "Chọn tỉnh, thành phố",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: LightColor.lightGrey,
        leadingWidth: 30,
        leading: BlocBuilder<PostUpdateBloc, PostUpdateState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  state.cityText.length > 0
                      ? context
                          .read<PostUpdateBloc>()
                          .add(PostUpdateCityChanged(
                            invalid: false,
                          ))
                      : context
                          .read<PostUpdateBloc>()
                          .add(PostUpdateCityChanged(
                            invalid: true,
                          ));
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back));
          },
        ),
      ),
      body: BlocBuilder<PostUpdateBloc, PostUpdateState>(
        builder: (context, state) {
          switch (state.positionUpdateStatus) {
            case PositionUpdateStatus.loading:
              return SplashPage();
              break;
            case PositionUpdateStatus.failure:
              return SplashPage();

              break;
            default:
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.cities.length,
                itemBuilder: (context, index) {
                  return SelectContainer(
                    title: state.cities[index].title,
                  ).ripple(() {
                    context.read<PostUpdateBloc>().add(PostUpdateCityChanged(
                          id: state.cities[index].id,
                          text: state.cities[index].title,
                          invalid: false,
                        ));
                    Navigator.pop(context);
                  });
                },
              );
          }
        },
      ),
    );
  }
}

class PostUpdateSelectDistrictPage extends StatelessWidget {
  final Function onPressed;

  const PostUpdateSelectDistrictPage({Key key, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: "Chọn quận, huyện",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: LightColor.lightGrey,
        leadingWidth: 30,
        leading: BlocBuilder<PostUpdateBloc, PostUpdateState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  state.districtText.length > 0
                      ? context
                          .read<PostUpdateBloc>()
                          .add(PostUpdateDistrictChanged(
                            invalid: false,
                          ))
                      : context
                          .read<PostUpdateBloc>()
                          .add(PostUpdateDistrictChanged(
                            invalid: true,
                          ));
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back));
          },
        ),
      ),
      body: BlocBuilder<PostUpdateBloc, PostUpdateState>(
        builder: (context, state) {
          switch (state.positionUpdateStatus) {
            case PositionUpdateStatus.loading:
              return SplashPage();
              break;
            case PositionUpdateStatus.failure:
              return SplashPage();

              break;
            default:
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.districts.length,
                itemBuilder: (context, index) {
                  return SelectContainer(
                    title: state.districts[index].title,
                  ).ripple(() {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateDistrictChanged(
                          id: state.districts[index].id,
                          text: state.districts[index].title,
                          invalid: false,
                        ));
                    Navigator.pop(context);
                  });
                },
              );
          }
        },
      ),
    );
  }
}

class PostUpdateSelectWardPage extends StatelessWidget {
  final Function onPressed;

  const PostUpdateSelectWardPage({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: "Chọn phường, xã",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: LightColor.lightGrey,
        leadingWidth: 30,
        leading: BlocBuilder<PostUpdateBloc, PostUpdateState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  state.wardText.length > 0
                      ? context
                          .read<PostUpdateBloc>()
                          .add(PostUpdateWardChanged(
                            invalid: false,
                          ))
                      : context
                          .read<PostUpdateBloc>()
                          .add(PostUpdateWardChanged(
                            invalid: true,
                          ));
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back));
          },
        ),
      ),
      body: BlocBuilder<PostUpdateBloc, PostUpdateState>(
        builder: (context, state) {
          switch (state.positionUpdateStatus) {
            case PositionUpdateStatus.loading:
              return SplashPage();
              break;
            case PositionUpdateStatus.failure:
              return SplashPage();

              break;
            default:
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.wards.length,
                itemBuilder: (context, index) {
                  return SelectContainer(
                    title: state.wards[index].title,
                  ).ripple(() {
                    context.read<PostUpdateBloc>().add(PostUpdateWardChanged(
                          id: state.wards[index].id,
                          text: state.wards[index].title,
                          invalid: false,
                        ));
                    Navigator.pop(context);
                  });
                },
              );
          }
        },
      ),
    );
  }
}

class SelectContainer extends StatelessWidget {
  final String title;
  const SelectContainer({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      height: AppTheme.fullHeight(context) * 0.05,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          TitleText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          Expanded(child: Container()),
          Icon(Icons.arrow_right, size: 30)
        ],
      ),
    );
  }
}
