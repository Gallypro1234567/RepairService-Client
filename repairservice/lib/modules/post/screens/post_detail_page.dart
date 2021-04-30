import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post/bloc/post_bloc.dart';
import 'package:repairservice/modules/post/screens/post_find_worker_page.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/widgets/title_text.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key key, this.post}) : super(key: key);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  image: post.imageUrl == null
                      ? DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage("assets/images/default.jpg"))
                      : DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(post.imageUrl))),
            ),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: TitleText(
              text: post.title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: kDefaultPadding / 2),
              height: AppTheme.fullHeight(context) * 0.1,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: AppTheme.fullHeight(context) * 0.1,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: post.customerImageUrl == null
                                ? AssetImage(
                                    "assets/images/user_profile_background.jpg")
                                : AssetImage(post.customerImageUrl),
                          ),
                        ),
                        SizedBox(
                          width: kDefaultPadding,
                        ),
                        TitleText(
                          text: post.fullname,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
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
                          RichText(
                            text: TextSpan(
                              text: 'Địa chỉ: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '${post.address == null ? "" : post.address} ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          RichText(
                            text: TextSpan(
                              text:
                                  '${post.desciption == null ? "" : post.desciption}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.user.isCustomer == UserType.worker &&
              state.user.role == 1) {
            return Container(
              height: AppTheme.fullHeight(context) * 0.1,
              color: Colors.grey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shadowColor: LightColor.lightGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0))),
                          key: key,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
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
                            context
                                .read<PostBloc>()
                                .add(PostWorkerApplySubmitted(post.code));
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
      ),
    );
  }
}
