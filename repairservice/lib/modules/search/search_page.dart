import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/search/bloc/search_bloc.dart';
import 'package:repairservice/modules/search/screens/select_city_page.dart';
import 'package:repairservice/modules/search/screens/select_service_page.dart';
import 'package:repairservice/modules/splash/loading_pages.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../utils/ui//extensions.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.lightGrey,
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Hero(
                      tag: 'background',
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          return SearchContainers(
                            controller: _controller,
                            onchanged: (val) {
                              context
                                  .read<SearchBloc>()
                                  .add(SearchChange(searhString: val));
                              context.read<SearchBloc>().add(SearchFetched());
                            },
                          );
                        },
                      )),
                ],
              )),
            ],
          ),
        ),
        leadingWidth: 30,
        leading: null,
        backgroundColor: LightColor.lightteal,
        elevation: 0,
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          switch (state.pageStatus) {
            case SearchStatus.loading:
              return SplashPage();
              break;
            case SearchStatus.failure:
              return Center(
                child: Text("Lỗi"),
              );
              break;
            default:
              return LoadingProcessPage(
                isLoading: state.pageStatus == SearchStatus.loading,
                child: RefreshIndicator(
                    onRefresh: () async {},
                    child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<SearchBloc>().add(SearchFetched());
                        },
                        child: ListPostView(
                          onSelectPosition: () {
                            context.read<SearchBloc>().add(SearchCityFetched());
                            Navigator.push(context,
                                SlideFadeRoute(page: SelectCityPage()));
                          },
                          onSelectService: () {
                            Navigator.push(context,
                                SlideFadeRoute(page: SelectServicePage()));
                          },
                        ))),
              );
          }
        },
      ),
    );
  }
}

class SearchContainers extends StatelessWidget {
  final String isActive;
  final TextEditingController controller;
  final Function(String) onchanged;

  const SearchContainers({
    Key key,
    this.isActive,
    this.controller,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .08
            : AppTheme.fullHeight(context) * .04,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: TextFormField(
          controller: controller,
          autofocus: true,
          onChanged: onchanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            focusColor: LightColor.lightteal,
            contentPadding: EdgeInsets.only(top: kDefaultPadding / 2),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: LightColor.lightteal)),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: "Bạn cần tìm dịch vụ gì ?",
          ),
        ),
      ),
    );
  }
}

class ListPostView extends StatelessWidget {
  final Function onSelectPosition;
  final Function onSelectService;
  final String titleCategory;
  const ListPostView({
    Key key,
    this.onSelectPosition,
    this.titleCategory,
    this.onSelectService,
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
                      BlocBuilder<SearchBloc, SearchState>(
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
                ).ripple(onSelectPosition),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                bottom: kDefaultPadding / 2),
            color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.filter_alt_sharp, size: 20, color: Colors.black),
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
                  child: Row(children: [
                    Container(
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          return TitleText(
                            text: state.serviceText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          );
                        },
                      ),
                    ),
                    Icon(FontAwesome.caret_down, size: 20, color: Colors.black),
                  ]),
                ).ripple(onSelectService)
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 6,
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return ListView.builder(
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
                                  PostdetailCheckWorker(
                                      state.posts[index].code));
                            context.read<PostdetailBloc>().add(
                                PostdetailFetched(state.posts[index].code));
                            Navigator.push(context,
                                SlideFadeRoute(page: PostDetailPage()));
                          });
                        },
                      ));
            },
          )
        ],
      ),
    );
  }
}

class ItemPostContainer extends StatelessWidget {
  final Post post;
  const ItemPostContainer({
    Key key,
    this.post,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kDefaultPadding / 6,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        height: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .4
            : AppTheme.fullHeight(context) * 0.15,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(
                  kDefaultPadding / 4,
                ),
                child: post.imageUrl == null
                    ? Image.asset("assets/images/default.jpg")
                    : CachedNetworkImage(
                        imageUrl: post.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                            child: Image.asset("assets/images/loading2.gif")),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: kDefaultPadding / 4),
                        child: TitleText(
                          text: post.title,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Icon(
                              Icons.menu,
                              color: Colors.blue,
                            ),
                          ),
                          TitleText(
                            text: post.serviceText == null
                                ? ""
                                : post.serviceText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                          TitleText(
                            text: post.address == null ? "" : post.address,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: Container()),
                          TitleText(
                            text: TimeAgo.timeAgoSinceDate(post.createAt),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
