import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/customer_manager/bloc/customermanager_bloc.dart';
import 'package:repairservice/modules/post_detail/components/post_detail_button.dart';
import 'package:repairservice/modules/post_rating/bloc/postrate_bloc.dart';
import 'package:repairservice/modules/post_rating/post_rating.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'bloc/customerdetail_bloc.dart';

class WorkerDetailPage extends StatefulWidget {
  const WorkerDetailPage({Key key}) : super(key: key);

  @override
  _WorkerDetailPageState createState() => _WorkerDetailPageState();
}

class _WorkerDetailPageState extends State<WorkerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerdetailBloc, CustomerdetailState>(
      listener: (context, state) {
        if (state.status == CustomerdetailStatus.submitted) {
          context
              .read<CustomerdetailBloc>()
              .add(CustomerDetailFetched(state.detail.first.phone));
          context.read<CustomermanagerBloc>().add(CustomermanagerInitial());
        }
      },
      child: BlocBuilder<CustomerdetailBloc, CustomerdetailState>(
        builder: (context, state) {
          switch (state.status) {
            case CustomerdetailStatus.loading:
              return Center(
                  child: LoadingProcessPage(
                color1: Colors.white,
                color2: Colors.white,
                color3: Colors.white,
              ));
              break;
            case CustomerdetailStatus.failure:
              return Center(
                child: Text("Error"),
              );
              break;
            default:
              return AnimatedSwitcher(
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    alwaysIncludeSemantics: true,
                    opacity: animation,
                    child: child,
                  );
                },
                duration: Duration(milliseconds: 200),
                switchInCurve: Curves.easeInToLinear,
                switchOutCurve: Curves.easeOutBack,
                child: Container(
                  height: AppTheme.fullHeight(context) * .9,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: Responsive.isTablet(context)
                            ? const EdgeInsets.only(top: 40)
                            : const EdgeInsets.only(top: 60),
                        child: Responsive.isTablet(context)
                            ? ProfileVer(
                                name: state.detail.first.fullname,
                                address: state.detail.first.address == null
                                    ? ""
                                    : state.detail.first.address,
                                sex: state.detail.first.sex == Sex.empty
                                    ? "Không rõ"
                                    : state.detail.first.sex == Sex.male
                                        ? "Nam"
                                        : state.detail.first.sex == Sex.female
                                            ? "Nữ"
                                            : "Khác",
                                email: state.detail.first.email,
                                phone: state.detail.first.phone,
                                status: state.detail.first.status,
                                activeByStatus: () {},
                              )
                            : ProfilHori(
                                name: state.detail.first.fullname,
                                address: state.detail.first.address == null
                                    ? ""
                                    : state.detail.first.address,
                                sex: state.detail.first.sex == Sex.empty
                                    ? "Không rõ"
                                    : state.detail.first.sex == Sex.male
                                        ? "Nam"
                                        : state.detail.first.sex == Sex.female
                                            ? "Nữ"
                                            : "Khác",
                                email: state.detail.first.email,
                                phone: state.detail.first.phone,
                                status: state.detail.first.status,
                                activeByStatus: () {},
                              ),
                      ),
                      Responsive.isTablet(context)
                          ? Positioned(
                              left: AppTheme.fullWidth(context) * .2,
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8.0,
                                      offset: Offset(0.0, 5.0),
                                    ),
                                  ],
                                ),
                                child: state.detail.first.imageUrl == null
                                    ? CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/user_profile_background.jpg"))
                                    : CachedNetworkImage(
                                        imageUrl: state.detail.first.imageUrl,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                              ))
                          : Positioned(
                              top: 0,
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8.0,
                                      offset: Offset(0.0, 5.0),
                                    ),
                                  ],
                                ),
                                child: state.detail.first.imageUrl == null
                                    ? CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/user_profile_background.jpg"))
                                    : CachedNetworkImage(
                                        imageUrl: state.detail.first.imageUrl,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                              )),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class ProfilHori extends StatelessWidget {
  final String name;
  final String phone;
  final String sex;
  final String address;
  final String email;
  final int status;
  final Function activeByStatus;
  final int amount;
  final int feedbackAmount;
  final double avgPointRating;
  final int finishAmount;
  final int cancelAmount;
  const ProfilHori({
    Key key,
    this.name,
    this.phone,
    this.sex,
    this.address,
    this.email,
    this.status,
    this.activeByStatus,
    this.amount,
    this.feedbackAmount,
    this.avgPointRating,
    this.finishAmount,
    this.cancelAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: AppTheme.fullHeight(context) * .7,
          minWidth: AppTheme.fullWidth(context),
          maxHeight: AppTheme.fullHeight(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      width: AppTheme.fullWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60 + kDefaultPadding,
          ),
          TitleText(
            text: name,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          Text(
            address,
            style: GoogleFonts.muli(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontStyle: FontStyle.italic),
          ),
          Container(
            height: kDefaultPadding,
          ),
          Container(
            height: AppTheme.fullHeight(context) * .08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 2,
                  child: Container(
                      child: PostDetailButton(
                    onPressed: status == -1
                        ? null
                        : () {
                            context.read<CustomerdetailBloc>().add(
                                CustomerActionAcountSubtmitted(
                                    status == 1 ? 0 : 1));
                          },
                    primaryColor:
                        status == 1 ? Colors.redAccent : LightColor.lightteal,
                    title: status == 1
                        ? "Khóa tài khoản"
                        : status == -1
                            ? "Không thể khóa"
                            : "Mở tài khoản",
                    textColor: status == -1 ? Colors.black : Colors.white,
                    icon: Container(),
                  )),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Container(
            height: kDefaultPadding,
          ),
          ReviewFeedBack(
            amount: 1,
            avgPointRating: 1,
            cancelAmount: 1,
            feedbackAmount: 1,
            finishAmount: 1,
          ),
          Container(
            height: kDefaultPadding,
          ),
          Detail(
            address: address,
            email: email,
            phone: phone,
            sex: sex,
            status: status,
          )
        ],
      ),
    );
  }
}

class ProfileVer extends StatelessWidget {
  final String name;
  final String phone;
  final String sex;
  final String address;
  final String email;
  final int status;
  final Function activeByStatus;
  final int amount;
  final int feedbackAmount;
  final double avgPointRating;
  final int finishAmount;
  final int cancelAmount;
  const ProfileVer({
    Key key,
    this.name,
    this.phone,
    this.sex,
    this.address,
    this.email,
    this.status,
    this.activeByStatus,
    this.amount,
    this.feedbackAmount,
    this.avgPointRating,
    this.finishAmount,
    this.cancelAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: AppTheme.fullHeight(context) * .7,
          minWidth: AppTheme.fullWidth(context),
          maxHeight: AppTheme.fullHeight(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      width: AppTheme.fullWidth(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60 + kDefaultPadding,
                  ),
                  TitleText(
                    text: name,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  Text(
                    address,
                    style: GoogleFonts.muli(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                  ),
                  Container(
                    height: kDefaultPadding,
                  ),
                  Container(
                    height: AppTheme.fullHeight(context) * .16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 2,
                          child: Container(
                              child: PostDetailButton(
                            onPressed: status == -1
                                ? null
                                : () {
                                    context.read<CustomerdetailBloc>().add(
                                        CustomerActionAcountSubtmitted(
                                            status == 1 ? 0 : 1));
                                  },
                            primaryColor: status == 1
                                ? Colors.redAccent
                                : LightColor.lightteal,
                            title: status == 1
                                ? "Khóa tài khoản"
                                : status == -1
                                    ? "Không thể khóa"
                                    : "Mở tài khoản",
                            textColor:
                                status == -1 ? Colors.black : Colors.white,
                            icon: Container(),
                          )),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  Container(
                    height: kDefaultPadding,
                  ),
                  status == -1
                      ? Container()
                      : ReviewFeedBack(
                          amount: 1,
                          avgPointRating: 1,
                          cancelAmount: 1,
                          feedbackAmount: 1,
                          finishAmount: 1,
                        ),
                  Container(
                    height: kDefaultPadding,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: kDefaultPadding,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: kDefaultPadding, left: kDefaultPadding),
              child: Detail(
                address: address,
                email: email,
                phone: phone,
                sex: sex,
                status: status,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final String phone;
  final String sex;
  final String address;
  final String email;
  final int status;
  const Detail({
    Key key,
    this.phone,
    this.sex,
    this.address,
    this.email,
    this.status,
  }) : super(key: key);

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
          Container(
            height: kDefaultPadding,
          ),
          Item(
            icon: Icon(Icons.email),
            title: "Số điện thoại ",
            text: phone,
          ),
          Container(
            height: kDefaultPadding,
          ),
          Item(
            icon: Icon(FontAwesome.venus_mars),
            title: "Giới tính ",
            text: sex,
          ),
          Container(
            height: kDefaultPadding,
          ),
          Item(
            icon: Icon(Icons.location_on),
            title: "Địa chỉ ",
            text: address,
          ),
          Container(
            height: kDefaultPadding,
          ),
          Item(
              icon: Icon(Icons.email),
              title: "Trạng thái ",
              text: status == 1
                  ? "đã kích hoạt"
                  : status == -1
                      ? "không thể khóa tài khoản"
                      : "đã bị khóa",
              colorsub: status == 1
                  ? Colors.blue
                  : status == -1
                      ? Colors.deepPurple
                      : Colors.red),
          Container(
            height: kDefaultPadding,
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
        ],
      ),
    );
  }
}

class ReviewFeedBack extends StatelessWidget {
  final int amount;
  final int feedbackAmount;
  final double avgPointRating;
  final int finishAmount;
  final int cancelAmount;
  const ReviewFeedBack({
    Key key,
    this.avgPointRating,
    this.amount,
    this.finishAmount,
    this.cancelAmount,
    this.feedbackAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                TitleText(
                  text: "20",
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                TitleText(
                  text: "Giao dịch",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          )),
          Container(
            height: AppTheme.fullHeight(context) * 0.05,
            width: 2,
            color: Colors.grey,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                TitleText(
                  text: "10",
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                TitleText(
                  text: "Hoàn thành",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          )),
          Container(
            height: AppTheme.fullHeight(context) * 0.05,
            width: 2,
            color: Colors.grey,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                TitleText(
                  text: "1",
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                SizedBox(
                  height: kDefaultPadding / 4,
                ),
                TitleText(
                  text: "Hủy bỏ",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          )),
          Container(
            height: AppTheme.fullHeight(context) * 0.05,
            width: 2,
            color: Colors.grey,
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
  final Color colorsub;
  const Item({
    Key key,
    this.icon,
    this.title,
    this.text,
    this.colorsub = Colors.black,
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
                    fontSize: 14, fontWeight: FontWeight.bold, color: colorsub),
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
