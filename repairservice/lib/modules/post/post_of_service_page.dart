import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/core/auth/authentication.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';

import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'bloc/post_bloc.dart';
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
        backgroundColor: LightColor.lightteal,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              focusColor: LightColor.grey,
              contentPadding: EdgeInsets.only(top: kDefaultPadding / 2),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: "Bạn cần tìm dịch vụ gì ?",
            ),
          ),
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.pageStatus) {
            case PostStatus.loading:
              return SplashPage();
            case PostStatus.loadSuccess:
              return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<PostBloc>()
                        .add(PostFetched(widget.serviceCode));
                  },
                  child: ListPostView(
                    state: state,
                  ));
            case PostStatus.sbumitSuccess:
              return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<PostBloc>()
                        .add(PostFetched(widget.serviceCode));
                  },
                  child: ListPostView(
                    state: state,
                  ));

            default:
              return Center(
                child: Text("Error"),
              );
          }
        },
      ),
    );
  }
}

class ListPostView extends StatelessWidget {
  final PostState state;
  const ListPostView({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: state.posts.length,
        itemBuilder: (context, index) =>
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authstate) {
                return ItemPostContainer(
                  post: state.posts[index],
                ).ripple(() {
                  if (authstate.user.isCustomer == UserType.worker)
                    context
                        .read<PostdetailBloc>()
                        .add(PostdetailCheckWorker(state.posts[index].code));
                  context
                      .read<PostdetailBloc>()
                      .add(PostdetailFetched(state.posts[index].code));
                  Navigator.push(
                      context, SlideFadeRoute(page: PostDetailPage()));
                });
              },
            ));
  }
}
