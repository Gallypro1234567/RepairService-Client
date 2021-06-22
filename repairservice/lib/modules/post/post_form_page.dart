import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post/bloc/post_bloc.dart';
import 'package:repairservice/modules/post/components/post_change_image.dart';

import 'package:repairservice/modules/post/screens/post_form_select_service.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'components/post_button.dart';
import 'components/post_form_input.dart';

import '../../utils/ui/extensions.dart';
import 'screens/post_form_select_position.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state.pageStatus == PostStatus.sbumitSuccess) {
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
          body: BlocBuilder<PostBloc, PostState>(
            buildWhen: (previousState, state) {
              if (previousState.pageStatus == PostStatus.loading)
                Navigator.pop(context, true);
              return true;
            },
            builder: (context, state) {
              switch (state.pageStatus) {
                case PostStatus.loading:
                  return Loading();
                  break;
                case PostStatus.failure:
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Error",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: kDefaultPadding / 2,
                      ),
                      Text(state.message)
                    ],
                  ));
                  break;
                default:
                  return FormBody();
                  break;
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
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state.images.length == 0) {
                  return PostChangedImage(
                    height: AppTheme.fullHeight(context) * 0.2,
                    width: AppTheme.fullWidth(context),
                    iconsize: 100,
                  ).ripple(() {
                    context
                        .read<PostBloc>()
                        .add(PostAddImageMutiChanged(ImageSource.camera));
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
                      .read<PostBloc>()
                      .add(PostAddImageMutiChanged(ImageSource.camera));
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
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Danh mục tin",
                  hintText: "Chưa có thông tin",
                  invalid: state.serviceInvalid,
                  errorText: state.serviceInvalid ? 'không được trống' : null,
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
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Tỉnh, thành phố",
                  hintText: "Chưa có thông tin",
                  invalid: state.cityInvalid,
                  errorText: state.cityInvalid ? 'không được trống' : null,
                  controler: new TextEditingController(text: state.cityText),
                ).ripple(() {
                  context.read<PostBloc>().add(PostCityFetched());
                  Navigator.push(
                      context, SlideFadeRoute(page: PostSelectCityPage()));
                });
              },
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return PostFormInput(
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
                            .read<PostBloc>()
                            .add(PostDistrictFetched(state.cityId));
                        Navigator.push(context,
                            SlideFadeRoute(page: PostSelectDistrictPage()));
                      });
              },
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return PostFormInput(
                  title: "Phường, xã",
                  hintText: "Chưa có thông tin",
                  invalid: state.wardInvalid,
                  errorText: state.wardInvalid ? 'không được trống' : null,
                  controler: new TextEditingController(text: state.wardText),
                ).ripple(state.districtText.length == 0
                    ? null
                    : () {
                        context.read<PostBloc>().add(PostWardFetched(
                            districtId: state.districtId,
                            provinceId: state.cityId));
                        Navigator.push(context,
                            SlideFadeRoute(page: PostSelectWardPage()));
                      });
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<PostBloc, PostState>(
              buildWhen: (previous, current) => previous.title != current.title,
              builder: (context, state) {
                return PostFormInput(
                  title: "Tiêu đề",
                  hintText: "Chưa có thông tin",
                  invalid: state.title.invalid,
                  errorText: state.title.invalid ? 'không được trống' : null,
                  initialValue: "",
                  onChanged: (value) {
                    context.read<PostBloc>().add(PostTitleChanged(value));
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
                  color: Colors.black54,
                ),
              ],
            ),
            BlocBuilder<PostBloc, PostState>(
              buildWhen: (previous, current) =>
                  previous.description != current.description,
              builder: (context, state) {
                return PostAreaInput(
                  invalid: state.description.invalid,
                  errorText:
                      state.description.invalid ? 'không được trống' : null,
                  initialValue: "",
                  onChanged: (value) {
                    context.read<PostBloc>().add(PostDescriptionChanged(value));
                  },
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 1,
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return PostButton(
                  title: "Đăng tin ngay",
                  color: LightColor.lightteal,
                  onPressed: state.formzstatus.isValidated &&
                          !state.cityInvalid &&
                          !state.districtInvalid &&
                          !state.wardInvalid &&
                          state.cityText.length > 0 &&
                          state.districtText.length > 0 &&
                          state.wardText.length > 0 &&
                          state.serviceText.length > 0
                      ? () {
                          context.read<PostBloc>().add(PostCustomerSubmitted());
                        }
                      : null,
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
  final File file;
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
                        fit: BoxFit.cover, image: NetworkImage(imageUrl))
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
                    .read<PostBloc>()
                    .add(PostDeleteImageMutiChanged(target));
              }, borderRadius: BorderRadius.all(Radius.circular(100))))
        ],
      ),
    );
  }
}
