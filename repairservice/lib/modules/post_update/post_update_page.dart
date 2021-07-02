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
import 'package:repairservice/modules/splash/loading_pages.dart';

import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';
import 'bloc/postupdate_bloc.dart';
import 'components/post_change_image.dart';
import 'components/post_form_input.dart';
import 'screens/post_form_select_position.dart';
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
            toolbarHeight: AppTheme.fullHeight(context) * .06,
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
            buildWhen: (previousState, state) {
              if (previousState.pageStatus == PostUpdateStatus.loading)
                Navigator.pop(context, true);
              return true;
            },
            builder: (context, state) {
              switch (state.pageStatus) {
                case PostUpdateStatus.loading:
                  return Loading();
                  break;
                case PostUpdateStatus.failure:
                  return Center(child: Text("Error"));
                default:
                  return FormBodyUpdate();
                  break;
              }
            },
          ),
        ));
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
                  controler: new TextEditingController(text: state.serviceText),
                  // initialValue: state.serviceText,
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
                return PostFormSelectInput(
                  title: "Tỉnh, thành phố",
                  hintText: "Chưa có thông tin",
                  errorText: state.cityInvalid ? 'không được trống' : null,
                  initialValue: state.cityText,
                  controler: new TextEditingController(text: state.cityText),
                ).ripple(() {
                  context.read<PostUpdateBloc>().add(PostUpdateCityFetched());
                  Navigator.push(context,
                      SlideFadeRoute(page: PostUpdateSelectCityPage()));
                });
              },
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormSelectInput(
                  title: "Quận, huyện",
                  hintText: "Chưa có thông tin",
                  invalid: state.districtInvalid,
                  errorText: state.districtInvalid ? 'không được trống' : null,
                  controler:
                      new TextEditingController(text: state.districtText),
                ).ripple(state.cityText.length == 0
                    ? null
                    : () {
                        context
                            .read<PostUpdateBloc>()
                            .add(PostUpdateDistrictFetched(state.cityId));
                        Navigator.push(
                            context,
                            SlideFadeRoute(
                                page: PostUpdateSelectDistrictPage()));
                      });
              },
            ),
            BlocBuilder<PostUpdateBloc, PostUpdateState>(
              builder: (context, state) {
                return PostFormSelectInput(
                  title: "Phường, xã",
                  hintText: "Chưa có thông tin",
                  invalid: state.wardInvalid,
                  initialValue: state.wardText,
                  errorText: state.wardInvalid ? 'không được trống' : null,
                  controler: new TextEditingController(text: state.wardText),
                ).ripple(state.districtText.length == 0
                    ? null
                    : () {
                        context.read<PostUpdateBloc>().add(
                            PostUpdateWardFetched(
                                districtId: state.districtId,
                                provinceId: state.cityId));
                        Navigator.push(context,
                            SlideFadeRoute(page: PostUpdateSelectWardPage()));
                      });
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
                  invalid: state.title.invalid,
                  errorText: state.title.invalid ? 'không được trống' : null,
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
              buildWhen: (previous, current) =>
                  previous.description != current.description,
              builder: (context, state) {
                return PostAreaInput(
                  invalid: state.description.invalid,
                  initialValue: state.description.value,
                  errorText:
                      state.description.invalid ? 'không được trống' : null,
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
