import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post_find_worker/components/post_form_input.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'bloc/servicemanager_bloc.dart';

class ServiceManagerPage extends StatefulWidget {
  @override
  _ServiceManagerPageState createState() => _ServiceManagerPageState();
}

class _ServiceManagerPageState extends State<ServiceManagerPage> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: TitleText(
            text: 'Thêm mới Dịch vụ',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
                  builder: (context, state) {
                    return PostFormInput(
                      hintText: "Nhập tên dịch vụ",
                      title: "Tên dịch vụ",
                      onChanged: (value) {
                        context
                            .read<ServicemanagerBloc>()
                            .add(ServicemanagerNameChanged(value));
                      },
                    );
                  },
                ),
                BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
                  builder: (context, state) {
                    return PostFormInput(
                      hintText: "Mô tả dịch vụ",
                      title: "thông tin chi tiết",
                      onChanged: (value) {
                        context
                            .read<ServicemanagerBloc>()
                            .add(ServicemanagerDesciptionChanged(value));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Thoát'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
              builder: (context, state) {
                return TextButton(
                  child: Text('Thêm mới'),
                  onPressed: () {
                    context
                        .read<ServicemanagerBloc>()
                        .add(ServicemanagerEventSubmited());
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
            text: "Quản lý Service", fontSize: 16, fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<ServicemanagerBloc, ServicemanagerState>(
        listener: (context, state) {
          if (state.statusCode == 200) {
            context.read<HomeBloc>().add(HomeFetched());
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state.status) {
              case HomeStatus.loading:
                {
                  return SplashPage();
                }
              case HomeStatus.success:
                {
                  var datarows = state.services
                      .map((e) => DataRow(cells: <DataCell>[
                            DataCell(SizedBox(
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                backgroundImage: e.imageUrl != null
                                    ? NetworkImage(e.imageUrl)
                                    : null,
                              ),
                            )),
                            DataCell(Text(e.code)),
                            DataCell(Text(e.name)),
                          ]))
                      .toList();
                  return DataTableBloc(datarows: datarows);
                }
              default:
                return Center(
                  child: Text("Load data is failure"),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        child: Icon(FontAwesome.plus),
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
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: TitleText(
                text: 'Icon',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Code',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Dịch vụ',
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
