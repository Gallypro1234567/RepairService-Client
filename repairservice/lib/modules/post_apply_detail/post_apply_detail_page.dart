import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/worker_register_manager/components/item_detail_container.dart';
import 'package:repairservice/modules/home/home_page.dart';
import 'package:repairservice/modules/main_screen.dart';
import 'package:repairservice/modules/post_apply/bloc/postapply_bloc.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/components/post_detail_button.dart';
import 'package:repairservice/modules/post_rating/bloc/postrate_bloc.dart';
import 'package:repairservice/modules/post_rating/post_rating.dart';
import 'package:repairservice/modules/splash/loading_pages.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/ui/extensions.dart';
import 'bloc/postapplydetail_bloc.dart';
import 'components/post_apply_detail_container.dart';

class PostApplyWorkerDetailPage extends StatefulWidget {
  final int status;

  const PostApplyWorkerDetailPage({Key key, this.status}) : super(key: key);

  @override
  _PostApplyWorkerDetailPageState createState() =>
      _PostApplyWorkerDetailPageState();
}

class _PostApplyWorkerDetailPageState extends State<PostApplyWorkerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.lightGrey,
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: TitleText(
          text: "Thông tin chi tiết",
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
      body: BlocListener<PostapplydetailBloc, PostapplydetailState>(
        listener: (context, state) {
          if (state.status == ApplyDetailStatus.acceptSubmitted ||
              state.status == ApplyDetailStatus.cancelSubmitted) {
            context.read<PostapplyBloc>().add(PostapplyFetched(
                  state.postCode,
                ));
          }
        },
        child: BlocBuilder<PostapplydetailBloc, PostapplydetailState>(
          // buildWhen: (previousState, state) {
          //   if (previousState.status == ApplyDetailStatus.loading)
          //     Navigator.pop(context, true);
          //   return true;
          // },
          builder: (context, state) {
            switch (state.status) {
              case ApplyDetailStatus.loading:
                return SplashPage();
                break;
              case ApplyDetailStatus.success:
                return PostApplyDetailContainer(
                  children: [
                    WorkerProfile(model: state.postApply),
                    Content(model: state.postApply, status: widget.status)
                  ],
                );
                break;
              case ApplyDetailStatus.acceptSubmitted:
                return PostApplyDetailContainer(
                  children: [
                    WorkerProfile(model: state.postApply),
                    Content(model: state.postApply, status: 2)
                  ],
                );
                break;
              case ApplyDetailStatus.cancelSubmitted:
                return PostApplyDetailContainer(
                  children: [
                    WorkerProfile(model: state.postApply),
                    Content(model: state.postApply, status: 1)
                  ],
                );
                break;
              case ApplyDetailStatus.failure:
                return Center(
                  child: Text("Error"),
                );
                break;
              default:
                return PostApplyDetailContainer(
                  children: [
                    WorkerProfile(model: state.postApply),
                    Content(model: state.postApply, status: widget.status)
                  ],
                );
                break;
            }
          },
        ),
      ),
      bottomSheet: Container(
        height: AppTheme.fullHeight(context) * 0.1,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<PostapplydetailBloc, PostapplydetailState>(
                builder: (context, state) {
                  return PostDetailButton(
                    icon: Icon(
                      Icons.call,
                      size: 30,
                    ),
                    title: "Gọi điện",
                    textColor: Colors.white,
                    primaryColor: Colors.green,
                    shadowColor: LightColor.lightGrey,
                    onPressed: () {
                      context
                          .read<PostapplydetailBloc>()
                          .add(PostApplyOpenPhoneCall(state.postApply.phone));
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<PostapplydetailBloc, PostapplydetailState>(
                builder: (context, state) {
                  return PostDetailButton(
                    icon: Icon(
                      Icons.thumb_up,
                      size: 30,
                    ),
                    title: "Xem Đánh giá",
                    textColor: Colors.white,
                    primaryColor: Colors.indigo,
                    shadowColor: LightColor.lightGrey,
                    onPressed: () {
                      context.read<PostrateBloc>().add(PostrateFetched(
                          postCode: "", wofscode: state.wofscode));
                      Navigator.push(
                          context, SlideFadeRoute(page: PostRatingPage()));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final WorkerApply model;
  final int status;
  const Content({Key key, this.model, this.status}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemDetailContainer(
          title: "SĐT:",
          value: widget.model.phone,
        ),
        ItemDetailContainer(
          title: "Địa chỉ:",
          value: widget.model.address == null ? "" : widget.model.address,
        ),
        ItemDetailContainer(
          title: "CMND:",
          value: widget.model.cmnd == null ? "" : widget.model.cmnd,
        ),
        ItemDetailContainer(
            title: "Nghề nghiệp:", value: widget.model.serviceName),
        ItemDetailContainer(
          title: "Thời gian apply:",
          value: widget.model.createAt,
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<PostapplydetailBloc, PostapplydetailState>(
                builder: (context, state) {
                  return WorkerRegisterButton(
                    title: widget.status != 1 ? "Màn hình chính" : "Chấp nhận",
                    color: widget.status != 1 ? Colors.green : LightColor.red,
                    colorActive: LightColor.lightteal,
                    onPressed: widget.status != 1
                        ? () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                SlideFadeRoute(page: MainPage()),
                                (route) => false);
                          }
                        : () {
                            context.read<PostapplydetailBloc>().add(
                                PostdetailAcceptSubmitted(
                                    postCode: state.postCode,
                                    workerofservicecode: state.wofscode));
                          },
                  );
                },
              ),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            widget.status != 2
                ? Container()
                : Expanded(
                    child:
                        BlocBuilder<PostapplydetailBloc, PostapplydetailState>(
                      builder: (context, state) {
                        return WorkerRegisterButton(
                          title: "Hủy bỏ",
                          color: LightColor.red,
                          colorActive: LightColor.lightteal,
                          onPressed: () {
                            context.read<PostapplydetailBloc>().add(
                                PostApplyDetailCancelSubmitted(
                                    postCode: state.postCode,
                                    workerofservicecode: state.wofscode));
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
      ],
    );
  }
}

class WorkerProfile extends StatelessWidget {
  final WorkerApply model;

  const WorkerProfile({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: kDefaultPadding / 2, bottom: kDefaultPadding / 2),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: LightColor.lightGrey, width: 1))),
      alignment: Alignment.topCenter,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              // decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: model.imageUrl != null
              //         ? DecorationImage(image: NetworkImage(model.imageUrl))
              //         : DecorationImage(
              //             image: AssetImage(
              //                 "assets/images/user_profile_background.jpg"))),
              child: model.imageUrl == null
                  ? Image.asset("assets/images/user_profile_background.jpg")
                  : CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
            TitleText(
              text: model.fullname,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (v) {},
                        starCount: 5,
                        rating: 3,
                        size: 30.0,
                        isReadOnly: true,
                        color: Colors.green,
                        borderColor: Colors.green,
                        spacing: 0.0),
                  ],
                ),
                Positioned(
                  bottom: kDefaultPadding / 4,
                  right: kDefaultPadding / 2,
                  child: RichText(
                    text: TextSpan(
                      text: '10/20',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                      // children: <TextSpan>[
                      //   TextSpan(
                      //       text: '10/20',
                      //       style: TextStyle(fontWeight: FontWeight.bold)),
                      // ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerRegisterButton extends StatelessWidget {
  final title;
  final Function onPressed;
  final Color color;
  final Color colorActive;
  const WorkerRegisterButton({
    Key key,
    this.title,
    this.onPressed,
    this.color,
    this.colorActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: colorActive,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
            height: AppTheme.fullHeight(context) * 0.06,
            width: AppTheme.fullWidth(context) * 0.7,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: TitleText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ))),
      ),
      onPressed: onPressed,
    );
  }
}
