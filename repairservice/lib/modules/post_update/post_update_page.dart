import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post/components/post_button.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';

import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';
import 'bloc/postupdate_bloc.dart';
import 'components/post_change_image.dart';
import 'components/post_form_input.dart';
import 'screens/post_form_select_service.dart';

class PostUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostUpdateBloc, PostUpdateState>(
        listener: (context, state) {
          if (state.pageStatus == PostUpdateStatus.sbumitSuccess) {
            context.read<PostdetailBloc>().add(PostdetailFetched(state.code));
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            bottomOpacity: 0,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [],
            title: TitleText(
              text: "Tạo bài viết",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: BlocBuilder<PostUpdateBloc, PostUpdateState>(
            builder: (context, state) {
              switch (state.pageStatus) {
                case PostUpdateStatus.loading:
                  return SplashPage();
                  break;
                case PostUpdateStatus.none:
                  return FormBodyUpdate();
                  break;
                case PostUpdateStatus.loadSuccess:
                  return FormBodyUpdate();
                  break;
                case PostUpdateStatus.sbumitSuccess:
                  return FormBodyUpdate();
                  break;
                default:
                  return Center(child: Text("Error"));
              }
            },
          ),
        ));
  }
}

class FormBody extends StatelessWidget {
  const FormBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: Column(
          children: [
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                if (state.images.length == 0) {
                  return PostChangedImage(
                    height: AppTheme.fullHeight(context) * 0.2,
                    width: AppTheme.fullWidth(context),
                    iconsize: 100,
                  ).ripple(() {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateAddImageMutiChanged(ImageSource.camera));
                  }, borderRadius: BorderRadius.circular(10));
                }
                List<Widget> list = [];
                for (var item in state.images) {
                  list.add(
                    ImageSelected(
                      file: item,
                      status: false,
                      target: state.images.indexOf(item),
                    ),
                  );
                }
                list.add(PostChangedImage(
                  height: 150,
                  width: 150,
                  iconsize: 30,
                ).ripple(() {
                  context
                      .read<PostUpdateBloc>()
                      .add(PostUpdateAddImageMutiChanged(ImageSource.camera));
                }, borderRadius: BorderRadius.circular(10)));

                return Container(
                  width: AppTheme.fullWidth(context),
                  height: AppTheme.fullWidth(context) * .3,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: list,
                  ),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Danh mục tin",
                  hintText: "Chưa có thông tin",
                  controler: new TextEditingController(text: state.serviceText),
                ).ripple(() {
                  Navigator.push(
                      context, SlideFadeRoute(page: SelectServicePage()));
                });
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, usestate) {
                return PostFormInput(
                  title: "Bạn là",
                  hintText: "Chưa có thông tin",
                  readOnly: true,
                  controler:
                      new TextEditingController(text: usestate.user.fullname),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, usestate) {
                return PostFormInput(
                  title: "SĐT",
                  hintText: "Chưa có thông tin",
                  readOnly: true,
                  controler:
                      new TextEditingController(text: usestate.user.phone),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Địa chỉ",
                  hintText: "số nhà, quận huyện, thành phô",
                  onChanged: (value) {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateAddressChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Tiêu đề",
                  hintText: "Chưa có thông tin",
                  onChanged: (value) {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateTitleChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: "Thêm mô tả *",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostAreaInput(
                  onChanged: (value) {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateDescriptionChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 1,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostButton(
                  title: "Đăng tin ngay",
                  color: LightColor.lightteal,
                  onPressed: () {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateCustomerSubmitted());
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class FormBodyUpdate extends StatelessWidget {
  const FormBodyUpdate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: Column(
          children: [
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                if (state.images.length == 0) {
                  return PostChangedImage(
                    height: AppTheme.fullHeight(context) * 0.2,
                    width: AppTheme.fullWidth(context),
                    iconsize: 100,
                  ).ripple(() {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateAddImageMutiChanged(ImageSource.camera));
                  }, borderRadius: BorderRadius.circular(10));
                }
                List<Widget> list = [];
                for (var item in state.images) {
                  list.add(ImageSelected(
                    file: item,
                    status: item is String, // true image url/ false image file
                    target: state.images.indexOf(item),
                  ));
                }

                list.add(PostChangedImage(
                  height: 150,
                  width: 150,
                  iconsize: 30,
                ).ripple(() {
                  context
                      .read<PostUpdateBloc>()
                      .add(PostUpdateAddImageMutiChanged(ImageSource.camera));
                }, borderRadius: BorderRadius.circular(10)));

                return Container(
                  width: AppTheme.fullWidth(context),
                  height: AppTheme.fullWidth(context) * .3,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: list,
                  ),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Danh mục tin",
                  hintText: "Chưa có thông tin",
                  initialValue: state.serviceText,
                ).ripple(() {
                  Navigator.push(
                      context, SlideFadeRoute(page: SelectServicePage()));
                });
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, usestate) {
                return PostFormInput(
                  title: "Bạn là",
                  hintText: "Chưa có thông tin",
                  readOnly: true,
                  initialValue: usestate.user.fullname,
                  controler:
                      new TextEditingController(text: usestate.user.fullname),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, usestate) {
                return PostFormInput(
                  title: "SĐT",
                  hintText: "Chưa có thông tin",
                  readOnly: true,
                  initialValue: usestate.user.phone,
                  controler:
                      new TextEditingController(text: usestate.user.fullname),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Địa chỉ",
                  hintText: "số nhà, quận huyện, thành phô",
                  initialValue: state.address.value,
                  onChanged: (value) {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateAddressChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Tiêu đề",
                  hintText: "Chưa có thông tin",
                  initialValue: state.title.value,
                  onChanged: (value) {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateTitleChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: "Thêm mô tả *",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostAreaInput(
                  initialValue: state.description.value,
                  onChanged: (value) {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateDescriptionChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 1,
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostButton(
                  title: "Cập nhật thông tin",
                  color: LightColor.lightteal,
                  onPressed: () {
                    context
                        .read<PostUpdateBloc>()
                        .add(PostUpdateCustomerSubmitted());
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ImageSelected extends StatelessWidget {
  final String imageUrl;
  final dynamic file;
  final bool status;
  final int target;
  const ImageSelected({
    Key key,
    this.imageUrl,
    this.file,
    this.status,
    this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(kDefaultPadding / 4),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: status
                    ? DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(file))
                    : DecorationImage(
                        fit: BoxFit.cover, image: FileImage(file))),
          ),
          Positioned(
              top: -1,
              right: -1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ).ripple(() {
                context
                    .read<PostUpdateBloc>()
                    .add(PostUpdateDeleteImageMutiChanged(target));
              }, borderRadius: BorderRadius.all(Radius.circular(100))))
        ],
      ),
    );
  }
}
