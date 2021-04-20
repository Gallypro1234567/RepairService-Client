import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'bloc/workermanager_bloc.dart';

class WorkerManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
            text: "Quản lý thợ", fontSize: 16, fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<WorkermanagerBloc, WorkermanagerState>(
        builder: (context, state) {
          switch (state.status) {
            case WorkermanagerStatus.loading:
              return SplashPage();
            case WorkermanagerStatus.success:
              var list = <DataRow>[];
              for (final e in state.users) {
                list.add(new DataRow(
                    color: state.users.indexOf(e).isEven
                        ? MaterialStateColor.resolveWith(
                            (states) => LightColor.lightGrey)
                        : MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                    cells: <DataCell>[
                      DataCell(SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                            backgroundImage: e.imageUrl != null
                                ? NetworkImage(e.imageUrl)
                                : null),
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
                        text: e.email,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ]));
              }
              var datarows = state.users
                  .map((e) => DataRow(cells: <DataCell>[
                        DataCell(SizedBox(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(
                              backgroundImage: e.imageUrl != null
                                  ? NetworkImage(e.imageUrl)
                                  : null),
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
                          text: e.email,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                      ]))
                  .toList();
              return WorkerManagerDataTable(dataRows: list);
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

class WorkerManagerDataTable extends StatelessWidget {
  final List<DataRow> dataRows;
  const WorkerManagerDataTable({
    Key key,
    this.dataRows,
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
                text: '',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Thợ',
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
          ],
          rows: dataRows,
        ),
      ),
    );
  }
}
