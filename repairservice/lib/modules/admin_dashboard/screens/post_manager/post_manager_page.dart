import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/splash/loading_pages.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'bloc/postmanager_bloc.dart';

class PostmanagerPage extends StatefulWidget {
  @override
  _PostmanagerPageState createState() => _PostmanagerPageState();
}

class _PostmanagerPageState extends State<PostmanagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: TitleText(
            text: "Quản lý Đăng tin",
            fontSize: 16,
            fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<PostmanagerBloc, PostmanagerState>(
        listener: (context, state) {},
        child: BlocBuilder<PostmanagerBloc, PostmanagerState>(
           buildWhen: (previousState, state) {
            if (previousState.status == PostManagerStatus.loading)
              Navigator.pop(context, true);
            return true;
          },
          builder: (context, state) {
            switch (state.status) {
              case PostManagerStatus.loading:
                return Loading();
              case PostManagerStatus.failure:
                return Center(
                  child: Text("Error"),
                );
              default:
                var datarows = state.posts
                    .map((e) => DataRow(
                            onSelectChanged: (selected) {
                              if (selected) {
                                context
                                    .read<PostdetailBloc>()
                                    .add(PostdetailFetched(e.code));
                                Navigator.push(
                                    context,
                                    SlideFadeRoute(
                                        page: PostDetailPage(
                                      postCode: e.code,
                                    )));
                              }
                            },
                            cells: <DataCell>[
                              DataCell(SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  // backgroundImage: e.imageUrl != null
                                  //     ? NetworkImage(e.imageUrl)
                                  //     : null,
                                  child: e.imageUrl == null
                                      ? Image.asset(
                                          "assets/images/background_default.jpg")
                                      : CachedNetworkImage(
                                          imageUrl: e.imageUrl,
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
                                ),
                              )),
                              DataCell(Text(e.title)),
                              DataCell(Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 2),
                                child: StatusContainer(
                                  color: e.status == 0 || e.status == 1
                                      ? Colors.amber
                                      : e.status != 2
                                          ? Colors.blue
                                          : Colors.green,
                                  title: e.status == 0 || e.status == 1
                                      ? "Chưa có nhân viên"
                                      : e.status != 2
                                          ? "Đã Đánh giá"
                                          : "Hoàn thành",
                                  textColor: e.status == 0 || e.status == 1
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              )),
                              DataCell(
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: kDefaultPadding / 2),
                                  child: e.approval == 0
                                      ? Button(
                                          title: "Cần duyệt",
                                          color: Colors.red,
                                          textColor: Colors.white,
                                          onPressed: e.status == 0
                                              ? () {
                                                  context
                                                      .read<PostdetailBloc>()
                                                      .add(PostdetailFetched(
                                                          e.code));
                                                  Navigator.push(
                                                      context,
                                                      SlideFadeRoute(
                                                          page: PostDetailPage(
                                                        postCode: e.code,
                                                      )));
                                                }
                                              : null,
                                        )
                                      : e.approval == 1
                                          ? StatusContainer(
                                              color: Colors.green,
                                              title: "Đã Duyệt",
                                              textColor: Colors.white,
                                            )
                                          : StatusContainer(
                                              color: Colors.grey,
                                              title: "Duyệt thất bại",
                                              textColor: Colors.black,
                                            ),
                                ),
                              ),
                              DataCell(Text(e.fullname)),
                              DataCell(Text(e.phone)),
                            ]))
                    .toList();
                return RefreshIndicator(
                    onRefresh: () async {
                      context.read<PostmanagerBloc>().add(PostmanagerFetched());
                    },
                    child: DataTableBloc(datarows: datarows));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //context.read<PostmanagerBloc>().add(PostmanagerNew());
        },
        child: Icon(Entypo.plus),
      ),
    );
  }
}

class DataTableBloc extends StatelessWidget {
  final List<DataRow> datarows;
  const DataTableBloc({
    Key key,
    this.datarows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(
              label: TitleText(
                text: 'Ảnh',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Tiêu đề',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Trạng thái',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Phê duyệt',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Khách hàng',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Điện thoại',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          rows: datarows,
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final title;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final IconData icon;
  const Button({
    Key key,
    this.title,
    this.onPressed,
    this.color,
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: LightColor.lightGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon == null
                    ? Container()
                    : Column(
                        children: [
                          Icon(
                            icon,
                            color: textColor,
                          ),
                          SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                        ],
                      ),
                TitleText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor),
              ],
            )),
      ),
      onPressed: onPressed,
    );
  }
}

class StatusContainer extends StatelessWidget {
  final title;
  final Color color;
  final Color textColor;
  const StatusContainer({
    Key key,
    this.title,
    this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Responsive.isTablet(context)
            ? AppTheme.fullWidth(context) * .2
            : AppTheme.fullWidth(context) * .3,
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 4, vertical: kDefaultPadding / 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: LightColor.lightGrey,
                  offset: Offset(5, 5),
                  blurRadius: 10)
            ]),
        alignment: Alignment.center,
        child: Column(
          children: [
            TitleText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor),
          ],
        ));
  }
}
