import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/home/bloc/home_bloc.dart';
import 'package:repairservice/modules/post/components/post_form_input.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'bloc/preferentialmanager_bloc.dart';

class PreferentialManagerPage extends StatefulWidget {
  @override
  _PreferentialManagerPageState createState() =>
      _PreferentialManagerPageState();
}

class _PreferentialManagerPageState extends State<PreferentialManagerPage> {
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
                BlocBuilder<PreferentialmanagerBloc, PreferentialmanagerState>(
                  builder: (context, state) {
                    return PostFormInput(
                      title: "Tiêu đề",
                      hintText: "chưa có thông tin",
                      onChanged: (value) {
                        context
                            .read<PreferentialmanagerBloc>()
                            .add(PreferentialmanagerTitleChanged(value));
                      },
                    );
                  },
                ),
                BlocBuilder<PreferentialmanagerBloc, PreferentialmanagerState>(
                  builder: (context, state) {
                    return PostFormInput(
                      title: "Miêu tả",
                      hintText: "chưa có thông tin",
                      onChanged: (value) {
                        context
                            .read<PreferentialmanagerBloc>()
                            .add(PreferentialmanagerDescriptionChanged(value));
                      },
                    );
                  },
                ),
                BlocBuilder<PreferentialmanagerBloc, PreferentialmanagerState>(
                  builder: (context, state) {
                    return PostFormInput(
                      title: "Từ ngày",
                      hintText: "hh/MM/yyyy ",
                      onChanged: (value) {
                        context
                            .read<PreferentialmanagerBloc>()
                            .add(PreferentialmanagerFromDateChanged(value));
                      },
                    );
                  },
                ),
                BlocBuilder<PreferentialmanagerBloc, PreferentialmanagerState>(
                  builder: (context, state) {
                    return PostFormInput(
                      title: "Đến ngày",
                      hintText: "hh/MM/yyyy",
                      onChanged: (value) {
                        context
                            .read<PreferentialmanagerBloc>()
                            .add(PreferentialmanagerToDateChanged(value));
                      },
                    );
                  },
                ),
                BlocBuilder<PreferentialmanagerBloc, PreferentialmanagerState>(
                  builder: (context, state) {
                    return PostFormInput(
                      title: "Ưu đãi(%)",
                      hintText: "",
                      onChanged: (value) {
                        context
                            .read<PreferentialmanagerBloc>()
                            .add(PreferentialmanagerPercentChanged(value));
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
            BlocBuilder<PreferentialmanagerBloc, PreferentialmanagerState>(
              builder: (context, state) {
                return TextButton(
                  child: Text('Thêm mới'),
                  onPressed: () {
                    context
                        .read<PreferentialmanagerBloc>()
                        .add(PreferentialmanagerSubmitted());
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
            text: "Quản lý Ưu đãi", fontSize: 16, fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<PreferentialmanagerBloc, PreferentialmanagerState>(
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
                  var datarows = state.preferentials
                      .map((e) => DataRow(cells: <DataCell>[
                            DataCell(SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(e.imageUrl))),
                              ),
                            )),
                            DataCell(Text(e.code)),
                            DataCell(Text(e.title)),
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
