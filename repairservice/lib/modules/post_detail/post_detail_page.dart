import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/post_update/bloc/postupdate_bloc.dart';
import 'package:repairservice/modules/post_update/post_update_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
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
      bottomSheet: PostDetailBottomSheet(
        postCode: postCode,
      ),
    );
  }
}

class PostDetailBottomSheet extends StatelessWidget {
  final String postCode;

  const PostDetailBottomSheet({Key key, this.postCode}) : super(key: key);
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
        return BlocBuilder<PostdetailBloc, PostdetailState>(
          builder: (context, poststate) {
            if (poststate.post.phone == state.user.phone)
              return Container(
                height: AppTheme.fullHeight(context) * 0.1,
                color: Colors.grey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
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
                                text: "Cập nhật thông tin",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ))),
                        ),
                        onPressed: () {
                          context
                              .read<PostUpdateBloc>()
                              .add(PostUpdateFetched(postCode));
                          Navigator.push(
                              context, SlideFadeRoute(page: PostUpdatePage()));
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
                              alignment: Alignment.center,
                              child: Center(
                                  child: TitleText(
                                text: "Danh sách thợ",
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
            return Container(height: AppTheme.fullHeight(context) * 0.1);
          },
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

class PostDetailImageShowBloc extends StatefulWidget {
  const PostDetailImageShowBloc({
    Key key,
  }) : super(key: key);

  @override
  _PostDetailImageShowBlocState createState() =>
      _PostDetailImageShowBlocState();
}

class _PostDetailImageShowBlocState extends State<PostDetailImageShowBloc> {
  int currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostdetailBloc, PostdetailState>(
      builder: (context, state) {
        List<Widget> list = [];
        if (state.post.imageUrls.length == 0) {
          list
            ..add(Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/images/default.jpg"))),
            ));
        }
        for (var item in state.post.imageUrls) {
          list
            ..add(Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth, image: NetworkImage(item))),
            ));
        }
        return Center(
          child: Column(
            children: [
              CarouselSlider(
                  items: list,
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: state.post.imageUrls.length != 0 ? true : false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPos = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list.map((url) {
                  int index = list.indexOf(url);
                  return Container(
                    width: 20.0,
                    height: 2.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: currentPos == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
