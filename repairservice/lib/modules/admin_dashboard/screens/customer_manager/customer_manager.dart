import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/customer_detail/bloc/customerdetail_bloc.dart';
import 'package:repairservice/modules/admin_dashboard/screens/customer_detail/customer_detail_page.dart';
import 'package:repairservice/modules/admin_dashboard/screens/customer_detail/worker_detail_page.dart';
import 'package:repairservice/modules/splash/loading_process_page.dart';
import 'package:repairservice/utils/ui/reponsive.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'bloc/customermanager_bloc.dart';

class CustomerManagerPage extends StatefulWidget {
  @override
  State<CustomerManagerPage> createState() => _CustomerManagerPageState();
}

class _CustomerManagerPageState extends State<CustomerManagerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Responsive.isTablet(context)
            ? AppTheme.fullHeight(context) * .1
            : AppTheme.fullHeight(context) * .06,
        title: TitleText(
            text: "Quản lý Khách hàng",
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
      body: BlocListener<CustomermanagerBloc, CustomermanagerState>(
        listener: (context, state) {},
        child: BlocBuilder<CustomermanagerBloc, CustomermanagerState>(
          buildWhen: (previousState, state) {
            if (previousState.status == CustomermanagerStatus.loading)
              Navigator.pop(context, true);
            return true;
          },
          builder: (context, state) {
            switch (state.status) {
              case CustomermanagerStatus.loading:
                return Loading();
              case CustomermanagerStatus.failure:
                return Center(child: Text("Error"));
              default:
                var datarows = state.users
                    .map((e) => DataRow(
                            onSelectChanged: (selected) {
                              if (selected) {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    context
                                        .read<CustomerdetailBloc>()
                                        .add(CustomerDetailFetched(e.phone));
                                    return CustomerDetailPage();
                                  },
                                );
                              }
                            },
                            cells: <DataCell>[
                              DataCell(SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  child: e.imageUrl == null
                                      ? Image.asset(
                                          "assets/images/user_profile_background.jpg")
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
                              DataCell(TitleText(
                                text: e.fullname,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                              DataCell(TitleText(
                                text: e.phone,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                              DataCell(TitleText(
                                text: e.email == null ? "" : e.email,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                              DataCell(Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 2),
                                child: StatusContainer(
                                  color:
                                      e.status == 1 ? Colors.green : Colors.red,
                                  title: e.status == 1
                                      ? "Đang hoạt động"
                                      : "Đã khóa",
                                  textColor: Colors.white,
                                ),
                              )),
                            ]))
                    .toList();
                return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<CustomermanagerBloc>()
                          .add(CustomermanagerInitial());
                    },
                    child: CustomerManagerDataTable(dataRows: datarows));
            }
          },
        ),
      ),
    );
  }
}

class CustomerManagerDataTable extends StatelessWidget {
  final List<DataRow> dataRows;
  const CustomerManagerDataTable({
    Key key,
    this.dataRows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            columns: const <DataColumn>[
              DataColumn(
                label: TitleText(
                  text: '',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              DataColumn(
                label: TitleText(
                  text: 'Khách hàng',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              DataColumn(
                label: TitleText(
                  text: 'Điện thoại',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              DataColumn(
                label: TitleText(
                  text: 'Địa chỉ',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              DataColumn(
                label: TitleText(
                  text: 'Trạng thái',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            rows: dataRows,
          ),
        ),
      ),
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
            ? AppTheme.fullWidth(context) * .3
            : AppTheme.fullWidth(context) * .4,
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
