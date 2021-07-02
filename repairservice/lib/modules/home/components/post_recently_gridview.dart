import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/home/components/shimmer_post_container.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';
import 'post_recently_container.dart';

class PostRecently extends StatelessWidget {
  const PostRecently({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.loading:
            return SplashPage();
          case HomeStatus.failure:
            return Center(
              child: Text("Error"),
            );
          default:
            return PostRecenttlyGridview(
              posts: state.postRecently,
              length: state.hasReachedMax
                  ? state.postRecently.length
                  : state.postRecently.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.postRecently.length &&
                        state.hasReachedMax == false
                    ? Center(
                        child: Container(
                          height: Responsive.isTablet(context)
                              ? AppTheme.fullHeight(context) * .3
                              : AppTheme.fullHeight(context) * .1,
                          width: AppTheme.fullWidth(context),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/loading.gif"))),
                        ),
                      )
                    : BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, authstate) {
                          return PostRecentlyContainer(
                            post: state.postRecently[index],
                          ).ripple(() {
                            if (authstate.user.isCustomer == UserType.worker)
                              context.read<PostdetailBloc>().add(
                                  PostdetailCheckWorker(
                                      state.postRecently[index].code));
                            context.read<PostdetailBloc>().add(
                                PostdetailFetched(
                                    state.postRecently[index].code));
                            Navigator.push(
                                context,
                                SlideFadeRoute(
                                    page: PostDetailPage(
                                  postCode: state.postRecently[index].code,
                                )));
                          });
                        },
                      );
              },
            );
        }
      },
    );
  }
}

class PostRecenttlyGridview extends StatelessWidget {
  final ScrollController scrollController;
  final List<Post> posts;
  final int length;
  final Function(BuildContext, int) itemBuilder;

  const PostRecenttlyGridview({
    Key key,
    this.posts = const <Post>[],
    this.scrollController,
    this.length,
    this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            height: kDefaultPadding * 2,
            padding: EdgeInsets.only(left: kDefaultPadding / 2),
            alignment: Alignment.centerLeft,
            child: TitleText(
              text: "Tin đăng gần đây",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: itemBuilder,
          ),
        ],
      ),
    );
  }
}
