import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post/components/post_button.dart';
import 'package:repairservice/modules/post/components/post_form_input.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'package:repairservice/modules/worker_history_work/screens/select_address_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../utils/ui/extensions.dart';

class FormRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkerregisterworkBloc, WorkerregisterworkState>(
        listener: (context, state) {
          if (state.status == WorkerRegisterStatus.registerSuccessed) {
            context
                .read<WorkerregisterworkBloc>()
                .add(WorkerregisterworkServiceRegisterLoad());
            Navigator.pop(context);
          }
          if (state.status == WorkerRegisterStatus.exitFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Đã tồn tại thông tin đăng ký')),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            bottomOpacity: 0,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [],
            title: TitleText(
              text: "Đăng ký để trở thành thợ",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Column(
                children: [
                  DottedBorder(
                    dashPattern: [5, 5],
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    padding: EdgeInsets.all(6),
                    child: Container(
                        padding: EdgeInsets.only(
                          top: kDefaultPadding,
                        ),
                        height: AppTheme.fullHeight(context) * 0.2,
                        width: AppTheme.fullWidth(context),
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: LightColor.lightteal,
                              size: 100,
                            ),
                            TitleText(
                              text: "Chọn ảnh",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        )),
                  ).ripple(() {}),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
                    builder: (context, state) {
                      return PostSelectInput(
                        title: "Danh mục tin",
                        hintText: "Chưa có thông tin",
                        controler:
                            new TextEditingController(text: state.serviceText),
                      ).ripple(() {
                        Navigator.push(context,
                            SlideFadeRoute(page: WorkerSelectAddressPage()));
                      });
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, usestate) {
                      return PostFormInput(
                        title: "Bạn là",
                        hintText: "Chưa có thông tin",
                        readOnly: true,
                        controler: new TextEditingController(
                            text: usestate.user.fullname),
                      );
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  // PostFormInput(
                  //   title: "CMND",
                  //   hintText: "Chưa có thông tin",
                  // ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
                    builder: (context, state) {
                      return PostButton(
                        title: "Đăng tin ngay",
                        color: LightColor.lightteal,
                        onPressed: () {
                          context
                              .read<WorkerregisterworkBloc>()
                              .add(WorkerregisterworkSubmitted());
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
