import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post_detail_perfect/bloc/postdetailperfect_bloc.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'bloc/postrate_bloc.dart';
import 'components/area_input.dart';
import 'components/coment_container.dart';
import 'components/review_chart.dart';
import 'components/review_feedback.dart';
import 'components/worker_info_container.dart';

class PostRatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 30,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          actions: [
            BlocBuilder<PostrateBloc, PostrateState>(
              builder: (context, state) {
                if (state.postcode == null)
                  return Container();
                else if (state.postcode.length == 0)
                  return Container();
                else
                  return TextButton(
                      onPressed: !state.postDisable
                          ? null
                          : () {
                              context
                                  .read<PostrateBloc>()
                                  .add(PostratePosted());
                            },
                      child: TitleText(
                        text: "Đăng",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: !state.postDisable ? Colors.grey : Colors.green,
                      ));
              },
            )
          ],
        ),
        body: BlocListener<PostrateBloc, PostrateState>(
          listener: (context, state) {
            if (state.status == PostRatingStatus.submitted) {
              context.read<PostdetailperfectBloc>().add(
                  PostdetailperfectFetched(
                      postCode: state.postcode, isCustomer: true));
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<PostrateBloc, PostrateState>(
            builder: (context, state) {
              switch (state.status) {
                case PostRatingStatus.loading:
                  return SplashPage();
                  break;
                case PostRatingStatus.failure:
                  return Center(
                    child: Text("Error"),
                  );
                  break;
                default:
                  return Body(
                    model: state,
                  );
              }
            },
          ),
        ));
  }
}

class Body extends StatelessWidget {
  final PostrateState model;
  const Body({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkerInfoContainer(
                fullname: model.workerRating.fullname,
                phone: model.workerRating.phone,
                imageUrl: model.workerRating.imageUrl != null
                    ? model.workerRating.imageUrl.isNotEmpty
                        ? NetworkImage(model.workerRating.imageUrl)
                        : AssetImage(
                            "assets/images/user_profile_background.jpg")
                    : AssetImage("assets/images/user_profile_background.jpg"),
                wofsText: model.workerRating.services,
              ),
              ReviewFeedBack(
                feedbackAmount: model.workerRating.feedbackAmount,
                avgPointRating: model.workerRating.avgPoint,
                amount: model.workerRating.postAmount,
                finishAmount: model.workerRating.finishAmount,
                cancelAmount: model.workerRating.cancelAmount,
                
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Container(
                  width: AppTheme.fullWidth(context),
                  height: 0.5,
                  color: Colors.grey),
              SizedBox(
                height: kDefaultPadding,
              ),
              model.postcode.isNotEmpty
                  ? CustomerRating()
                  : Column(
                      children: [
                        BlocBuilder<PostrateBloc, PostrateState>(
                          builder: (context, state) {
                            return ReviewChart(
                              pointRating:  state.workerRating.avgPoint,
                              feedbackAmount: state.workerRating.feedbackAmount,
                              fivePercent: state.workerRating.fivePercent * 100,
                              fourPercent: state.workerRating.fourPercent * 100,
                              threePercent:
                                  state.workerRating.threePercent * 100,
                              twoPercent: state.workerRating.twoPercent * 100,
                              onePercent: state.workerRating.onePercent * 100,
                            );
                          },
                        ),
                        BlocBuilder<PostrateBloc, PostrateState>(
                          builder: (context, state) {
                            if (state.feedbacks.length == 0) return Container();
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.feedbacks.length,
                              itemBuilder: (context, index) {
                                return CommentsContainer(
                                    fullName: state.feedbacks[index].username,
                                    createAt: TimeAgo.timeAgoSinceDate(
                                        state.feedbacks[index].createAt),
                                    image: state.feedbacks[index]
                                                .userImageUrl !=
                                            null
                                        ? state.feedbacks[index].userImageUrl
                                                .isNotEmpty
                                            ? NetworkImage(state
                                                .feedbacks[index].userImageUrl)
                                            : AssetImage(
                                                "assets/images/user_profile_background.jpg")
                                        : AssetImage(
                                            "assets/images/user_profile_background.jpg"),
                                    description:
                                        state.feedbacks[index].description,
                                    pointRating: state.feedbacks[index].rate);
                              },
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerRating extends StatelessWidget {
  const CustomerRating({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingContainer(),
        SizedBox(
          height: kDefaultPadding,
        ),
        TitleText(
          text: "Viết bài đánh giá",
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        BlocBuilder<PostrateBloc, PostrateState>(
          builder: (context, state) {
            return DescriptionField(
              hindText: 'Mô tả đánh giá của bạn (Không bắt buộc)',
              onChanged: (val) {
                context
                    .read<PostrateBloc>()
                    .add(PostrateDescriptionChanged(val));
              },
            );
          },
        ),
      ],
    );
  }
}

class RatingContainer extends StatelessWidget {
  const RatingContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
            text: "Đánh giá nhân viên này",
            fontSize: 16,
            fontWeight: FontWeight.w700),
        TitleText(
            text: "Cho biết suy nghĩ của bạn",
            fontSize: 12,
            fontWeight: FontWeight.w500),
        SizedBox(
          height: kDefaultPadding,
        ),
        BlocBuilder<PostrateBloc, PostrateState>(
          builder: (context, state) {
            return SmoothStarRating(
                allowHalfRating: false,
                onRated: (v) {
                  context.read<PostrateBloc>().add(PostrateRatingChanged(v));
                },
                starCount: 5,
                rating: state.rating,
                size: AppTheme.fullWidth(context) * 0.1,
                isReadOnly: false,
                color: Colors.green,
                borderColor: Colors.green,
                spacing: kDefaultPadding * 2);
          },
        ),
      ],
    );
  }
}
