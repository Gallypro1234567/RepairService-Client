import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';

import 'package:repairservice/core/user/login/bloc/login_bloc.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/post_rating/bloc/postrate_bloc.dart';
import 'package:repairservice/modules/post_rating/post_rating.dart'; 
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/modules/user_profile/bloc/userprofile_bloc.dart';
import 'package:repairservice/modules/user_profile/user_profile_update_page.dart';
import 'package:repairservice/modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'package:repairservice/modules/worker_history_work/user_history_work_screen.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../utils/ui/extensions.dart';
import 'bloc/user_bloc.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: TitleText(
          text: "Thông tin cá nhân",
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        backgroundColor: LightColor.lightteal,
      ),
      body: Stack(
        children: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {},
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                switch (state.status) {
                  case UserStatus.loading:
                    return SplashPage();
                  case UserStatus.failure:
                    return Center(
                      child: Text("Error Loading data"),
                    );

                  default:
                    return UserWidget(state: state);
                }
              },
            ),
          ),
          Positioned(
              top: AppTheme.fullHeight(context) * .25,
              right: kDefaultPadding / 2,
              child: FloatingActionButton(
                backgroundColor: LightColor.lightGreen,
                mini: true,
                onPressed: () {
                  context.read<UserProfileBloc>().add(UserProfileInitial());
                  Navigator.push(
                      context, SlideFadeRoute(page: UserProfileUpdatePage()));
                },
                child: Icon(Icons.edit_rounded, color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  final UserState state;

  const UserWidget({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(UserFetch());
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: LightColor.lightGrey),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Avt(
                state: state,
              ),
              SizedBox(
                height: kDefaultPadding / 4,
              ),
              Trailer(state: state),
              SizedBox(
                height: kDefaultPadding / 4,
              ),
              Address(state: state),
              SizedBox(
                height: kDefaultPadding / 4,
              ),
              Container(
                child: state.user.isCustomer == UserType.worker
                    ? state.user.role == 1
                        ? Work(
                            state: state,
                            onPressed: () {
                              context
                                  .read<WorkerregisterworkBloc>()
                                  .add(WorkerregisterworkServiceRegisterLoad());
                              Navigator.push(
                                  context,
                                  SlideFadeRoute(
                                      page: WorkerHistoryWorkPage()));
                            })
                        : null
                    : null,
              ),
              _LogOutSubmitted(),
              Container(
                  color: Colors.white,
                  height: AppTheme.fullHeight(context) * .1)
            ],
          ),
        ),
      ),
    );
  }
}

class _LogOutSubmitted extends StatelessWidget {
  const _LogOutSubmitted({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          width: AppTheme.fullWidth(context),
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: Button(
              title: "Đăng xuất",
              onPressed: () {
                context.read<UserBloc>().add(UserInitial());
                context.read<ManagerBloc>().add(ManagerInitial());
                context.read<LoginBloc>().add(LogOuttSubmitted());
              },
              icon: FontAwesome.power_off,
              color: LightColor.lightBlue),
        );
      },
    );
  }
}

class Trailer extends StatelessWidget {
  const Trailer({
    Key key,
    @required this.state,
  }) : super(key: key);

  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2,
            ),
            child: Row(
              children: [
                TitleText(
                    text: "Giới Thiệu",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),
          Item(
            icon: Icon(Icons.person),
            title: state.user.role == 1
                ? state.user.isCustomer == UserType.worker
                    ? "Thợ "
                    : "Khách hàng "
                : "Quản trị viên ",
            text: state.user.fullname,
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Item(
            icon: Icon(FontAwesome.venus_mars),
            title: "Giới tính ",
            text: state.user.sex == Sex.female
                ? "Nữ"
                : state.user.sex == Sex.male
                    ? "Nam"
                    : state.user.sex == Sex.orther
                        ? "Khác"
                        : "Chưa rõ",
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Item(
            icon: Icon(
              Icons.online_prediction,
              color: Colors.green,
            ),
            title: "Đang hoạt động",
            text: "",
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final Icon icon;
  final String title;
  final String text;
  const Item({
    Key key,
    this.icon,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: kDefaultPadding / 2,
        ),
        RichText(
          text: TextSpan(
            text: title,
            style: GoogleFonts.muli(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemSub extends StatelessWidget {
  final Icon icon;
  final String title;
  final String text;
  final double fontsize;
  final FontWeight fontWeight;
  final Color fontColor;
  const ItemSub({
    Key key,
    this.icon,
    this.title,
    this.text,
    this.fontsize = 14,
    this.fontWeight = FontWeight.bold,
    this.fontColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: kDefaultPadding / 2,
        ),
        RichText(
          text: TextSpan(
            text: title,
            style: GoogleFonts.muli(
                fontSize: fontsize, fontWeight: fontWeight, color: fontColor),
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Work extends StatelessWidget {
  final UserState state;
  final Function onPressed;
  const Work({
    Key key,
    @required this.state,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                TitleText(
                    text: "Công việc",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                Expanded(child: SizedBox()),
                TextButton(
                  onPressed: onPressed,
                  child: TitleText(
                    text: "Đăng ký thêm ngành nghề mới",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.workeRegister.length,
            itemBuilder: (context, index) {
              if (state.workeRegister[index].isApproval == 1)
                return Container(
                  height: Responsive.isTablet(context)
                      ? AppTheme.fullHeight(context) * .08
                      : AppTheme.fullHeight(context) * .04,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Item(
                          icon: Icon(Icons.work),
                          title: "${state.workeRegister[index].serviceName}",
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        child: ItemSub(
                          title: "",
                          text:
                              "${state.workeRegister[index].feedbackPoint.toStringAsFixed(2)}",
                          fontsize: 12,
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.black,
                          icon:
                              Icon(FontAwesome.thumbs_o_up, color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Expanded(
                        child: ItemSub(
                          title: "",
                          text: "${state.workeRegister[index].reviewAmount}",
                          fontsize: 12,
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.black,
                          icon: Icon(
                            FontAwesome.comments_o,
                            color: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ).ripple(() {
                  context.read<PostrateBloc>().add(PostrateFetched(
                      postCode: "", wofscode: state.workeRegister[index].code));
                  Navigator.push(
                      context, SlideFadeRoute(page: PostRatingPage()));
                });
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class Feedback extends StatelessWidget {
  final Function onPressed;
  const Feedback({
    Key key,
    @required this.state,
    this.onPressed,
  }) : super(key: key);

  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                TitleText(
                    text: "Đánh giá ",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                Expanded(child: SizedBox()),
                TextButton(
                  onPressed: onPressed,
                  child: TitleText(
                    text: "Chi tiết ",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Item(
            title: "Điểm ",
            text: "3.1",
            icon: Icon(FontAwesome.thumbs_o_up, color: Colors.blue),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Item(
            title: "Đánh giá ",
            text: "4",
            icon: Icon(
              FontAwesome.comments_o,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}

class Address extends StatelessWidget {
  const Address({
    Key key,
    @required this.state,
  }) : super(key: key);

  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2,
            ),
            child: Row(
              children: [
                TitleText(
                    text: "Thông tin liên lạc",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          Item(
            icon: Icon(Icons.location_on),
            title: "Địa chỉ ",
            text: state.user.address,
          ),
          Item(
            icon: Icon(Icons.email),
            title: "Email ",
            text: state.user.email,
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
        ],
      ),
    );
  }
}

class Avt extends StatelessWidget {
  const Avt({
    Key key,
    @required this.state,
  }) : super(key: key);

  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
      width: AppTheme.fullWidth(context),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: CircleAvatar(
                child: state.user.imageUrl == null
                    ? Image.asset("assets/images/user_profile_background.jpg")
                    : CachedNetworkImage(
                        imageUrl: state.user.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          TitleText(
            text: state.user.fullname.toUpperCase(),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final title;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final IconData icon;
  const Button({
    Key key,
    this.title,
    this.onPressed,
    this.color,
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            shadowColor: LightColor.lightGrey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        key: key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Container(
              height: AppTheme.fullHeight(context) * 0.06,
              width: AppTheme.fullWidth(context) * 0.7,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: textColor,
                  ),
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  TitleText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ],
              )),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
