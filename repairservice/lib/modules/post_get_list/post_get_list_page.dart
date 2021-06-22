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
import 'package:repairservice/modules/splash/loading_process_page.dart';

import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
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
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        backgroundColor: LightColor.lightteal,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: BlocBuilder<PostgetlistBloc, PostgetlistState>(
          builder: (context, state) {
            return SearchContainer(
              onChanged: (val) {
                context.read<PostgetlistBloc>().add(PostgetlistFetched(
                    searchText: val,
                    cityId: state.cityId,
                    districtId: state.districtId,
                    code: state.serviceCode));
              },
            );
          },
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: BlocBuilder<PostgetlistBloc, PostgetlistState>(
        buildWhen: (previousState, state) {
          if (previousState.pageStatus == PostGetStatus.loading)
            Navigator.pop(context, true);
          return true;
        },
        builder: (context, state) {
          switch (state.pageStatus) {
            case PostGetStatus.loading:
              return Loading();
            case PostGetStatus.failure:
              return Center(
                child: Text("Error"),
              );

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
                    onSelect: () {
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
  final Function onSelect;
  final String titleCategory;
  const ListPostView({
    Key key,
    this.state,
    this.onSelect,
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
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 4,
                      vertical: kDefaultPadding / 4),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
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
                      Icon(FontAwesome.caret_down,
                          size: 20, color: Colors.black),
                    ],
                  ),
                ).ripple(onSelect),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
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
                  ))
        ],
      ),
    );
  }
}
