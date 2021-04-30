import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'bloc/postdetail_bloc.dart';

class PostDetailPage extends StatelessWidget {
  final String postCode;
  const PostDetailPage({Key key, this.postCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: "Trang tin chi tiết",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: LightColor.lightteal,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<PostdetailBloc, PostdetailState>(
        builder: (context, state) {
          switch (state.status) {
            case PostDetailStatus.loading:
              return SplashPage();
              break;
            case PostDetailStatus.success:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocBuilder<PostdetailBloc, PostdetailState>(
                    builder: (context, state) {
                      List<Widget> list = [];
                      for (var item in state.post.imageUrls) {
                        list..add(Image.network(item));
                      }

                      return Expanded(
                        child: ImageSlideshow(
                          children: list,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  PostDetailTitleBloc(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  PostDescriptionBloc(),
                ],
              );
              break;
            case PostDetailStatus.submitted:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PostDetailImageShowBloc(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  PostDetailTitleBloc(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  PostDescriptionBloc(),
                ],
              );
              break;
            case PostDetailStatus.failure:
              return Center(
                child: Text("Error"),
              );
              break;
            default:
              return SplashPage();
          }
        },
      ),
      bottomSheet: PostDetailBottomSheet(),
    );
  }
}

class PostDetailBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.user.isCustomer == UserType.worker && state.user.role == 1) {
          return Container(
            height: AppTheme.fullHeight(context) * 0.1,
            color: Colors.grey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: BlocBuilder<PostdetailBloc, PostdetailState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shadowColor: LightColor.lightGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0))),
                        key: key,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                  child: TitleText(
                                text: "Nhận đơn",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ))),
                        ),
                        onPressed: () {
                          context.read<PostdetailBloc>().add(
                              PostdetailWorkerApplySubmitted(state.post.code));
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: LightColor.lightGrey,
                        shadowColor: LightColor.lightGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    key: key,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: TitleText(
                            text: "Nhắn tin",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ))),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: LightColor.lightGrey,
                        shadowColor: LightColor.lightGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    key: key,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: TitleText(
                            text: "Chat",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ))),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          height: AppTheme.fullHeight(context) * 0.1,
        );
      },
    );
  }
}

class PostDescriptionBloc extends StatelessWidget {
  const PostDescriptionBloc({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.only(left: kDefaultPadding / 2),
        height: AppTheme.fullHeight(context) * 0.1,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<PostdetailBloc, PostdetailState>(
              builder: (context, state) {
                return Container(
                  height: AppTheme.fullHeight(context) * 0.1,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: state.post.customerImageUrl == null
                              ? AssetImage(
                                  "assets/images/user_profile_background.jpg")
                              : AssetImage(state.post.customerImageUrl),
                        ),
                      ),
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      TitleText(
                        text: state.post.fullname,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                );
              },
            ),
            Divider(
              height: 1,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                height: AppTheme.fullHeight(context) * 0.1,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    TitleText(
                      text: "Thông tin chi tiết",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    BlocBuilder<PostdetailBloc, PostdetailState>(
                      builder: (context, state) {
                        return RichText(
                          text: TextSpan(
                            text: 'Địa chỉ: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${state.post.address == null ? "" : state.post.address} ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    BlocBuilder<PostdetailBloc, PostdetailState>(
                      builder: (context, state) {
                        return RichText(
                          text: TextSpan(
                            text:
                                '${state.post.desciption == null ? "" : state.post.desciption}',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostDetailTitleBloc extends StatelessWidget {
  const PostDetailTitleBloc({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostdetailBloc, PostdetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding / 2),
          child: TitleText(
            text: state.post.title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class PostDetailImageShowBloc extends StatelessWidget {
  const PostDetailImageShowBloc({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostdetailBloc, PostdetailState>(
      builder: (context, state) {
        List<Widget> list = [];
        for (var item in state.post.imageUrls) {
          list..add(Image.network(item));
        }

        return Expanded(
          child: ImageSlideshow(
            children: list,
            autoPlayInterval: 1,
          ),
        );
      },
    );
  }
}
