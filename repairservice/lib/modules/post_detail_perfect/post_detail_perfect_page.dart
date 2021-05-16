import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/manager/bloc/manager_bloc.dart';
import 'package:repairservice/modules/post_rating/bloc/postrate_bloc.dart';
import 'package:repairservice/modules/post_rating/post_rating.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../main_screen.dart';
import 'bloc/postdetailperfect_bloc.dart';

class PostDetailPerfectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: TitleText(
          text: "Thông tin công việc",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: LightColor.lightteal,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<PostdetailperfectBloc, PostdetailperfectState>(
          listener: (context, state) {
        if (state.status == PostPerfectStatus.perfectSubmitted ||
            state.status == PostPerfectStatus.cancelSubmitted ||
            state.status == PostPerfectStatus.customersubmitted) {
          context.read<PostdetailperfectBloc>().add(PostdetailperfectFetched(
              isCustomer: state.isCustomer, postCode: state.postCode));
          context.read<ManagerBloc>().add(ManagerFetched());
        }
      }, builder: (context, state) {
        return BlocBuilder<PostdetailperfectBloc, PostdetailperfectState>(
            builder: (context, state) {
          switch (state.status) {
            case PostPerfectStatus.loading:
              return SplashPage();
              break;
            case PostPerfectStatus.failure:
              return Center(
                child: Text("Error"),
              );
              break;
            default:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PostInformation(
                      postCode: state.post.postCode,
                      postName: state.post.postTitle,
                      serviceName: state.post.serviceName,
                      status: state.post.postStatus,
                    ),
                    CustomerInformation(
                        name: state.post.customerfullname,
                        phone: state.post.customerphone,
                        address: state.post.customerAddress == null
                            ? "Chưa có thông tin"
                            : state.post.customerAddress),
                    WorkerInformation(
                      name: state.post.workerfullname,
                      phone: state.post.workerphone,
                      address: "1212121212",
                      cmnd: state.post.workerCMND == null
                          ? "Chưa có thông tin"
                          : state.post.workerCMND,
                      applystatus: state.post.applyStatus,
                    ),
                    Container(
                      height: AppTheme.fullHeight(context) * 0.1,
                    )
                  ],
                ),
              );
          }
        });
      }),
      bottomSheet: BlocBuilder<PostdetailperfectBloc, PostdetailperfectState>(
        builder: (context, state) {
          switch (state.status) {
            case PostPerfectStatus.loading:
              return SplashPage();
              break;
            case PostPerfectStatus.failure:
              return Center(
                child: Text("Error"),
              );
              break;
            default:
              switch (state.isCustomer) {
                case false:
                  if (state.post.applyStatus == 2 && state.post.postStatus == 1)
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding / 2),
                      height: AppTheme.fullHeight(context) * 0.1,
                      width: AppTheme.fullWidth(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Xác nhận hoàn thành",
                              color: LightColor.lightteal,
                              onPressed: () {
                                context
                                    .read<PostdetailperfectBloc>()
                                    .add(PostdetailperfectWorkerSubmited());
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  else if (state.post.applyStatus == 3 &&
                      state.post.postStatus == 2)
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding / 2),
                      height: AppTheme.fullHeight(context) * 0.1,
                      width: AppTheme.fullWidth(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Màn hình chính",
                              color: LightColor.lightteal,
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    SlideFadeRoute(page: MainPage()),
                                    (route) => false);
                              },
                            ),
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Hủy",
                              color: Colors.red,
                              onPressed: () {
                                context
                                    .read<PostdetailperfectBloc>()
                                    .add(PostdetailWorkerCancelSubmited());
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  else if (state.post.postStatus == 3)
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding / 2),
                      height: AppTheme.fullHeight(context) * 0.1,
                      width: AppTheme.fullWidth(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Màn hình chính",
                              color: LightColor.lightteal,
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    SlideFadeRoute(page: MainPage()),
                                    (route) => false);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  else
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding / 2),
                      height: AppTheme.fullHeight(context) * 0.1,
                      width: AppTheme.fullWidth(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Xác nhận hoàn thành",
                              color: LightColor.lightteal,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Hủy",
                              color: Colors.red,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  break;
                default:
                  if (state.post.feedbackStatus == 1)
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding / 2),
                      height: AppTheme.fullHeight(context) * 0.1,
                      width: AppTheme.fullWidth(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Màn hình chính",
                              color: Colors.green,
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    SlideFadeRoute(page: MainPage()),
                                    (route) => false);
                              },
                            ),
                          ),
                          SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          Expanded(
                            child: WorkerRegisterButton(
                              title: "Đã đánh giá",
                              color: LightColor.lightteal,
                              colorText: Colors.black,
                              onPressed: null,
                            ),
                          ),
                        ],
                      ),
                    );
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2,
                        horizontal: kDefaultPadding / 2),
                    height: AppTheme.fullHeight(context) * 0.1,
                    width: AppTheme.fullWidth(context),
                    child: Row(
                      children: [
                        Expanded(
                          child: WorkerRegisterButton(
                            title: "Đánh giá",
                            color: LightColor.lightteal,
                            onPressed: () {
                              context.read<PostrateBloc>().add(PostrateFetched(
                                  postCode: state.post.postCode,
                                  wofscode: state.post.wofsCode));
                              Navigator.push(context,
                                  SlideFadeRoute(page: PostRatingPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                  break;
              }
              break;
          }
        },
      ),
    );
  }
}

class PostInformation extends StatelessWidget {
  final String postCode;
  final String postName;
  final String serviceName;
  final int status;
  const PostInformation({
    Key key,
    this.postCode,
    this.postName,
    this.serviceName,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            height: AppTheme.fullHeight(context) * 0.05,
            color: LightColor.lightGrey,
            alignment: Alignment.centerLeft,
            child: TitleText(
              text: "Thông tin đơn hàng",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          PostDetailPefectContainer(
            title: "Mã dịch vụ",
            value: postCode,
          ),
          PostDetailPefectContainer(
            title: "Tên dịch vụ",
            value: postName,
          ),
          PostDetailPefectStatusContainer(
            title: "Trạng thái",
            value: status != 2
                ? status != 1
                    ? "Đã hoàn thành"
                    : "Chưa hoàn thành"
                : "Đã hoàn thành",
            color: status != 2
                ? status != 1
                    ? Colors.red
                    : Colors.green
                : Colors.green,
            colorText: status != 2
                ? status != 1
                    ? Colors.white
                    : Colors.white
                : Colors.white,
          ),
          PostDetailPefectContainer(
            title: "Loại dịch vụ",
            value: serviceName,
          ),
        ],
      ),
    );
  }
}

class WorkerInformation extends StatelessWidget {
  final String name;
  final int applystatus;
  final String phone;
  final String address;
  final String cmnd;
  const WorkerInformation({
    Key key,
    this.name,
    this.applystatus,
    this.address,
    this.cmnd,
    this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            height: AppTheme.fullHeight(context) * 0.05,
            color: LightColor.lightGrey,
            alignment: Alignment.centerLeft,
            child: TitleText(
              text: "Thông tin nhân viên",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          PostDetailPefectContainer(title: "Nhân viên tiếp nhận", value: name),
          PostDetailPefectStatusContainer(
            title: "Trạng thái",
            value: applystatus != 3
                ? applystatus != 2
                    ? "Chưa có thông tin"
                    : "Nhân viên đã tiếp nhận"
                : "Nhân viên đã hoàn thành",
            color: applystatus != 3
                ? applystatus != 2
                    ? Colors.red
                    : Colors.amber
                : Colors.green,
            colorText: applystatus != 3
                ? applystatus != 2
                    ? Colors.white
                    : Colors.white
                : Colors.white,
          ),
          PostDetailPefectContainer(
            title: "Số điện thoại",
            value: phone,
          ),
          PostDetailPefectContainer(
            title: "Địa chỉ",
            value: address,
          ),
          PostDetailPefectContainer(
            title: "Số CMND",
            value: cmnd,
          ),
        ],
      ),
    );
  }
}

class CustomerInformation extends StatelessWidget {
  final String name;
  final String phone;

  final String address;
  const CustomerInformation({
    Key key,
    this.name,
    this.phone,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            height: AppTheme.fullHeight(context) * 0.05,
            color: LightColor.lightGrey,
            alignment: Alignment.centerLeft,
            child: TitleText(
              text: "Thông tin khách hàng",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          PostDetailPefectContainer(
            title: "Khách hàng",
            value: name,
          ),
          PostDetailPefectContainer(
            title: "Số điện thoại",
            value: phone,
          ),
          PostDetailPefectContainer(
            title: "Địa chỉ",
            value: address,
          ),
        ],
      ),
    );
  }
}

class PostDetailPefectContainer extends StatelessWidget {
  final String title;
  final String value;

  const PostDetailPefectContainer({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.fullHeight(context) * 0.05,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      margin: const EdgeInsets.only(
          top: kDefaultPadding / 2, bottom: kDefaultPadding / 2),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: LightColor.lightGrey, width: 1))),
      child: Row(
        children: [
          TitleText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          Expanded(child: Container()),
          TitleText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

class PostDetailPefectStatusContainer extends StatelessWidget {
  final String title;
  final String value;
  final Color colorText;
  final Color color;
  const PostDetailPefectStatusContainer({
    Key key,
    this.title,
    this.value,
    this.colorText,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.fullHeight(context) * 0.05,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      margin: const EdgeInsets.only(
          top: kDefaultPadding / 2, bottom: kDefaultPadding / 2),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: LightColor.lightGrey, width: 1))),
      child: Row(
        children: [
          TitleText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(50)),
            child: TitleText(
              text: value,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorText,
            ),
          ),
        ],
      ),
    );
  }
}

class WorkerRegisterButton extends StatelessWidget {
  final title;
  final Function onPressed;
  final Color color;
  final Color shadowColor;
  final Color colorText;
  const WorkerRegisterButton(
      {Key key,
      this.title,
      this.onPressed,
      this.color,
      this.shadowColor,
      this.colorText = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
            height: AppTheme.fullHeight(context) * 0.06,
            width: AppTheme.fullWidth(context) * 0.7,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            alignment: Alignment.center,
            child: TitleText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorText,
                textAlign: TextAlign.center)),
      ),
      onPressed: onPressed,
    );
  }
}
