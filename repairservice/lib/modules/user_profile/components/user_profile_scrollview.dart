import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/user_profile/bloc/userprofile_bloc.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils//ui/extensions.dart';

class UserProfileBackground extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Function onchangedAvatr;
  final String imageUrl;
  const UserProfileBackground(
      {Key key, this.title, this.onchangedAvatr, this.children, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: AppTheme.fullHeight(context) * 0.23,
            width: AppTheme.fullWidth(context),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: BlocBuilder<UserProfileBloc, UserProfileState>(
                          builder: (context, state) {
                            switch (state.filestatus) {
                              case FileStatus.loading:
                                return const CircularProgressIndicator();
                              case FileStatus.success:
                                return Container(
                                  child: CircleAvatar(
                                    backgroundImage: state.file != null
                                        ? FileImage(state.file)
                                        : imageUrl.isNotEmpty
                                            ? NetworkImage(imageUrl)
                                            : AssetImage(
                                                "assets/images/user_profile_background.jpg"),
                                  ),
                                );
                              case FileStatus.failure:
                                return CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/user_profile_background.jpg"),
                                );
                              default:
                                return CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/user_profile_background.jpg"),
                                );
                            }
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: LightColor.lightteal,
                            ),
                            onPressed: () {
                              Scaffold.of(context).showBottomSheet<void>(
                                (BuildContext context) {
                                  return _BottomSheet();
                                },
                              );
                            }),
                      )
                    ],
                  ),
                ),
                TitleText(
                  text: "Xin chào",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                TitleText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final Function camera;
  final Function gallery;
  const _BottomSheet({
    Key key,
    this.camera,
    this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: AppTheme.fullWidth(context),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: LightColor.orange,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: TitleText(
                          text: "Chọn ảnh",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TitleText(
                            text: "Chụp từ Camera",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).ripple(() {
                  context
                      .read<UserProfileBloc>()
                      .add(UserProfileImageChanged(ImageSource.camera));
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TitleText(
                            text: "Ảnh từ thư viện",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).ripple(() {
                  context
                      .read<UserProfileBloc>()
                      .add(UserProfileImageChanged(ImageSource.gallery));
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
