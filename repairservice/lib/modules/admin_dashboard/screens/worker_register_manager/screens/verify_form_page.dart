import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/worker_register_manager/bloc/workerregistermanager_bloc.dart';
import 'package:repairservice/modules/admin_dashboard/screens/worker_register_manager/components/item_detail_container.dart';
import 'package:repairservice/modules/post/screens/post_find_worker_page.dart';
import 'package:repairservice/repository/post_repository/models/time_ago.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../../../utils/ui/extensions.dart';

class VerificationFormPage extends StatelessWidget {
  final WorkerRegister model;
  const VerificationFormPage({Key key, this.model}) : super(key: key);

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
      body: BlocListener<WorkerregistermanagerBloc, WorkerregistermanagerState>(
        listener: (context, state) {
          if (state.status == WorkerregistermanagerStatus.submitted) {
            context
                .read<WorkerregistermanagerBloc>()
                .add(WorkerregistermanagerFetched());
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            width: AppTheme.fullWidth(context),
            padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 5),
                    blurRadius: 30,
                    color: LightColor.lightGrey,
                  ),
                  BoxShadow(
                    offset: Offset(5, 5),
                    blurRadius: 30,
                    color: LightColor.lightGrey,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [WorkerProfile(model: model), Content(model: model)],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: AppTheme.fullHeight(context) * .1,
        color: Colors.transparent,
        alignment: Alignment.center,
        child:
            BlocBuilder<WorkerregistermanagerBloc, WorkerregistermanagerState>(
          builder: (context, state) {
            return WorkerRegisterButton(
              title: state.changed == false ? "Đã Duyệt" : "Duyệt",
              color: LightColor.red,
              colorActive: LightColor.lightteal,
              onPressed: state.changed == false
                  ? null
                  : () {
                      context
                          .read<WorkerregistermanagerBloc>()
                          .add(WorkerregistermanagerSubmit(workerPhone:  model.phone, serviceCode: model.serviceCode));
                    },
            );
          },
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key key,
    @required this.model,
  }) : super(key: key);

  final WorkerRegister model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<WorkerregistermanagerBloc, WorkerregistermanagerState>(
          builder: (context, state) {
            context
                .read<WorkerregistermanagerBloc>()
                .add(WorkerregistermanagerCode(model.code));
            return ItemDetailContainer(
              title: "Mã đăng ký:",
              value: model.code,
            );
          },
        ),
        ItemDetailContainer(
          title: "Tên dịch vụ:",
          value: model.serviceName,
        ),
        ItemDetailContainer(
          title: "Mã dịch vụ:",
          value: model.serviceCode,
        ),
        ItemDetailContainer(
          title: "Số điện thoại:",
          value: model.phone,
          icon: Icon(Icons.call, color: LightColor.lightGreen),
        ).ripple(() {
          context
              .read<WorkerregistermanagerBloc>()
              .add(WorkerregistermanagerOpenPhoneCall(model.phone));
        }),
        ItemDetailContainer(
          title: "CMND:",
          value: model.cmnd == null ? "" : model.cmnd,
        ),
        ItemDetailContainer(
          title: "Địa chỉ:",
          value: model.address == null ? "" : model.address,
        ),
        ItemDetailContainer(
          title: "Thời gian đăng ký:",
          value: TimeAgo.timeAgoSinceDate(model.createAt),
        ),
        BlocBuilder<WorkerregistermanagerBloc, WorkerregistermanagerState>(
          builder: (context, state) {
            return ItemDetailSelectContainer(
              title: "Trạng thái :",
              value: state.formIsApproval == 0
                  ? "Chưa Duyệt"
                  : state.formIsApproval == 1
                      ? "Duyệt thành công"
                      : "Duyệt thất bại",
              onSelected: (value) {
                context
                    .read<WorkerregistermanagerBloc>()
                    .add(WorkerregistermanagerApprovalChanged(value));
              },
            );
          },
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
      ],
    );
  }
}

class WorkerProfile extends StatelessWidget {
  const WorkerProfile({
    Key key,
    @required this.model,
  }) : super(key: key);

  final WorkerRegister model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: kDefaultPadding / 2),
      height: AppTheme.fullHeight(context) * .2,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: LightColor.lightGrey, width: 1))),
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundImage: model.imageUrl == null
                          ? null
                          : NetworkImage(model.imageUrl),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Khách hàng: ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: model.fullname,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'SĐT: ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: model.phone,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Email: ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: model.email != null ? model.email : null,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Địa chỉ: ',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.normal,
                  //         fontSize: 16,
                  //         color: Colors.black),
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //           text: model.address != null ? model.address : null,
                  //           style: TextStyle(fontWeight: FontWeight.bold)),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WorkerRegisterButton extends StatelessWidget {
  final title;
  final Function onPressed;
  final Color color;
  final Color colorActive;
  const WorkerRegisterButton({
    Key key,
    this.title,
    this.onPressed,
    this.color,
    this.colorActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: colorActive,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
            height: AppTheme.fullHeight(context) * 0.06,
            width: AppTheme.fullWidth(context) * 0.7,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: TitleText(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ))),
      ),
      onPressed: onPressed,
    );
  }
}
