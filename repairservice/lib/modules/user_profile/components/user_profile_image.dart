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
import '../../../utils/ui/extensions.dart';

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
                    clipBehavior: Clip.none,
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
                                return CircleAvatar(
                                  backgroundImage: !state.fileInvalid
                                      ? FileImage(state.file)
                                      : imageUrl.isNotEmpty
                                          ? NetworkImage(imageUrl)
                                          : AssetImage(
                                              "assets/images/user_profile_background.jpg"),
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
                        right: -10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                              onPressed: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      MyActionSheet(),
                                );
                              }),
                        ),
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
            color: Colors.white,
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

class MyActionSheet extends StatelessWidget {
  const MyActionSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Chọn ảnh từ thư viện'),
          onPressed: () {
            context
                .read<UserProfileBloc>()
                .add(UserProfileImageChanged(ImageSource.gallery));
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Chụp hình'),
          onPressed: () {
            context
                .read<UserProfileBloc>()
                .add(UserProfileImageChanged(ImageSource.camera));
            Navigator.pop(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Hủy'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
