import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/service_manager/screens/bloc/updateservice_bloc.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post/components/post_form_input.dart';
import 'package:repairservice/modules/post_detail/bloc/postdetail_bloc.dart';
import 'package:repairservice/modules/post_detail/post_detail_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import '../../../../utils/ui/extensions.dart';
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
        toolbarHeight: AppTheme.fullHeight(context) * .06,
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
          builder: (context, state) {
            switch (state.status) {
              case PostManagerStatus.loading:
                return SplashPage();
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
                                  backgroundImage: e.imageUrl != null
                                      ? NetworkImage(e.imageUrl)
                                      : null,
                                ),
                              )),
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
                              DataCell(Text(e.title)),
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
                text: 'Tiêu đề',
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
        width: AppTheme.fullWidth(context) * .3,
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
