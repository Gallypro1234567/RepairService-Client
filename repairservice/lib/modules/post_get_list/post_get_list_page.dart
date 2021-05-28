import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';

import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/post_get_list/components/post_search_container.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/post_get_list/screens/select_city_page.dart';

import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'bloc/postgetlist_bloc.dart';
import 'components/post_item_container.dart';
import '../../utils/ui//extensions.dart';

class PostOfServicePage extends StatefulWidget {
  final String title;
  final String serviceCode;
  const PostOfServicePage({Key key, this.title, this.serviceCode})
      : super(key: key);
  @override
  _PostOfServicePageState createState() => _PostOfServicePageState();
}

class _PostOfServicePageState extends State<PostOfServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.lightGrey,
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        backgroundColor: LightColor.lightteal,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: SearchContainer(),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: BlocBuilder<PostgetlistBloc, PostgetlistState>(
        builder: (context, state) {
          switch (state.pageStatus) {
            case PostGetStatus.loading:
              return SplashPage();
            case PostGetStatus.failure:
              return Center(
                child: Text("Error"),
              );
            // case PostGetStatus.sbumitSuccess:
            //   return RefreshIndicator(
            //       onRefresh: () async {
            //         context
            //             .read<PostgetlistBloc>()
            //             .add(PostgetlistFetched(code: widget.serviceCode));
            //       },
            //       child: ListPostView(

            //         state: state,
            //       ));
            default:
              return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<PostgetlistBloc>()
                        .add(PostgetlistFetched(code: widget.serviceCode));
                  },
                  child: ListPostView(
                    titleCategory: widget.title,
                    state: state,
                    onNavigator: () {
                      context
                          .read<PostgetlistBloc>()
                          .add(PostgetlistCityFetched());
                      Navigator.push(
                          context, SlideFadeRoute(page: SelectCityPage()));
                    },
                  ));
          }
        },
      ),
    );
  }
}

class ListPostView extends StatelessWidget {
  final PostgetlistState state;
  final Function onNavigator;
  final String titleCategory;
  const ListPostView({
    Key key,
    this.state,
    this.onNavigator,
    this.titleCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
            color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.location_on, size: 20, color: Colors.black),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                TitleText(
                  text: "Khu vực: ",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                BlocBuilder<PostgetlistBloc, PostgetlistState>(
                  builder: (context, state) {
                    return TitleText(
                      text: state.districtQuery.length == 0
                          ? "${state.cityQuery}"
                          : "${state.districtQuery}, ${state.cityQuery} ",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
                Icon(FontAwesome.caret_down, size: 20, color: Colors.black),
                Expanded(
                  child: Container(),
                ),
                RichText(
                    text: TextSpan(
                        text: "Danh mục: ",
                        style: GoogleFonts.muli(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        children: [
                      TextSpan(
                          text: titleCategory,
                          style: GoogleFonts.muli(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ])),
              ],
            ),
          ).ripple(onNavigator),
          SizedBox(
            height: kDefaultPadding / 6,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.posts.length,
              itemBuilder: (context, index) =>
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, authstate) {
                      return ItemPostContainer(
                        post: state.posts[index],
                      ).ripple(() {
                        if (authstate.user.isCustomer == UserType.worker)
                          context.read<PostdetailBloc>().add(
                              PostdetailCheckWorker(state.posts[index].code));
                        context
                            .read<PostdetailBloc>()
                            .add(PostdetailFetched(state.posts[index].code));
                        Navigator.push(
                            context, SlideFadeRoute(page: PostDetailPage()));
                      });
                    },
                  )),
        ],
      ),
    );
  }
}
