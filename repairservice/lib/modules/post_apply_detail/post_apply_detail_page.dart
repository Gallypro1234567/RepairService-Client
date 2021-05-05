import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/worker_register_manager/components/item_detail_container.dart';
import 'package:repairservice/modules/home/home_page.dart';
import 'package:repairservice/modules/post_detail/components/post_detail_button.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/post_apply.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/ui/extensions.dart';
import 'bloc/postapplydetail_bloc.dart';
import 'components/post_apply_detail_container.dart';

class PostApplyWorkerDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.lightGrey,
      appBar: AppBar(
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
      body: BlocBuilder<PostapplydetailBloc, PostapplydetailState>(
        builder: (context, state) {
          switch (state.status) {
            case ApplyDetailStatus.loading:
              return SplashPage();
              break;
            case ApplyDetailStatus.success:
              return PostApplyDetailContainer(
                children: [
                  WorkerProfile(model: state.postApply),
                  Content(model: state.postApply)
                ],
              );
              break;
            case ApplyDetailStatus.failure:
              return Center(
                child: Text("Error"),
              );
              break;
            default:
              return SplashPage();
              break;
          }
        },
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
              child: PostDetailButton(
                title: "Nhắn tin",
                primaryColor: Colors.amber,
                shadowColor: LightColor.lightGrey,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final WorkerApply model;

  const Content({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemDetailContainer(
          title: "SĐT:",
          value: model.phone,
        ),
        ItemDetailContainer(
          title: "Địa chỉ:",
          value: model.address == null ? "" : model.address,
        ),
        ItemDetailContainer(
          title: "CMND:",
          value: model.cmnd == null ? "" : model.cmnd,
        ),
        ItemDetailContainer(title: "Nghề nghiệp:", value: model.serviceName),
        ItemDetailContainer(
          title: "Thời gian apply:",
          value: model.createAt,
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        BlocBuilder<PostapplydetailBloc, PostapplydetailState>(
          builder: (context, state) {
            return WorkerRegisterButton(
              title: "Chấp nhận",
              color: LightColor.red,
              colorActive: LightColor.lightteal,
              onPressed: () {
                context.read<PostapplydetailBloc>().add(
                    PostdetailAcceptSubmitted(
                        postCode: state.postCode,
                        workerofservicecode: state.wofscode));
                Navigator.push(context, SlideFadeRoute(page: HomePage()));
              },
            );
          },
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
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: model.imageUrl != null
                        ? DecorationImage(image: NetworkImage(model.imageUrl))
                        : DecorationImage(
                            image: AssetImage(
                                "assets/images/user_profile_background.jpg")))),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ))),
      ),
      onPressed: onPressed,
    );
  }
}
