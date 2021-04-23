import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';

import 'package:repairservice/modules/post/components/post_form_input.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';

import 'package:repairservice/widgets/title_text.dart';

import 'bloc/workerregistermanager_bloc.dart';
import 'screens/verify_form_page.dart';

class WorkerRegisterManagerPage extends StatefulWidget {
  @override
  _WorkerRegisterManagerPageState createState() =>
      _WorkerRegisterManagerPageState();
}

class _WorkerRegisterManagerPageState extends State<WorkerRegisterManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
            text: "Quản lý thợ đăng ký",
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
      body: BlocBuilder<WorkerregistermanagerBloc, WorkerregistermanagerState>(
        builder: (context, state) {
          switch (state.status) {
            case WorkerregistermanagerStatus.loading:
              return SplashPage();
            case WorkerregistermanagerStatus.success:
              var datarows = state.workerregister
                  .map((e) => DataRow(
                          onSelectChanged: (bool selected) {
                            if (selected) {
                              context.read<WorkerregistermanagerBloc>().add(
                                  WorkerregistermanagerFetchedDetail(
                                      code: e.code, isApproval: e.isApproval));

                              Navigator.push(
                                  context,
                                  SlideFadeRoute(
                                      page: VerificationFormPage(
                                    model: e,
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
                                      : null),
                            )),
                            DataCell(TitleText(
                              text: e.fullname,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                            DataCell(StatusContainer(
                              isApproval: e.isApproval,
                            )),
                            DataCell(TitleText(
                              text: e.phone,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                            DataCell(TitleText(
                              text: e.serviceName,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                          ]))
                  .toList();
              return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<WorkerregistermanagerBloc>()
                        .add(WorkerregistermanagerFetched());
                  },
                  child: WorkerRegisterManagerDataTable(dataRows: datarows));
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

class WorkerRegisterManagerDataTable extends StatelessWidget {
  final List<DataRow> dataRows;
  const WorkerRegisterManagerDataTable({
    Key key,
    this.dataRows,
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
                text: 'Trạng thái',
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
                text: 'Dịch vụ',
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

class StatusContainer extends StatelessWidget {
  final int isApproval;
  const StatusContainer({
    Key key,
    this.isApproval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: isApproval == 0
              ? Colors.amber
              : isApproval == 1
                  ? Colors.green
                  : Colors.red,
          borderRadius: BorderRadius.circular(50)),
      child: TitleText(
        text: isApproval == 0
            ? "Đang chờ xác nhận"
            : isApproval == 1
                ? "Duyệt thành công"
                : "Duyệt thất bại",
        color: isApproval == 0
            ? Colors.black
            : isApproval == 1
                ? Colors.white
                : Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
