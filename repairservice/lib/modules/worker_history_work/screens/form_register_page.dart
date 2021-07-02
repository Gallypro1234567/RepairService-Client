import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post/components/post_button.dart';
import 'package:repairservice/modules/post/components/post_form_input.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'package:repairservice/modules/worker_history_work/screens/select_service_page.dart';
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
          body: FormBody(),
        ));
  }
}

class FormBody extends StatelessWidget {
  const FormBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TitleText(
            //   text: "Chụp ảnh CMND (trước)",
            //   fontSize: 16,
            //   fontWeight: FontWeight.w500,
            // ),
            // SizedBox(
            //   height: kDefaultPadding,
            // ),
            // BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
            //   builder: (context, state) {
            //     if (!state.imageAfterInvalid) {
            //       return SelectImage(
            //         onPressedCancel: () {
            //           context
            //               .read<WorkerregisterworkBloc>()
            //               .add(WorkerregisterworkAfterDeleteImage());
            //         },
            //         child: Container(
            //             width: AppTheme.fullWidth(context),
            //             child: Image(
            //                 fit: BoxFit.cover,
            //                 image: FileImage(
            //                   state.imageCMNDAfter,
            //                 ))),
            //       );
            //     }
            //     return DottedBorderCamara().ripple(() {
            //       context.read<WorkerregisterworkBloc>().add(
            //           WorkerregisterworkImageAfterChanged(ImageSource.camera));
            //     });
            //   },
            // ),
            // SizedBox(
            //   height: kDefaultPadding * 2,
            // ),
            // TitleText(
            //   text: "Chụp ảnh CMND (sau)",
            //   fontSize: 16,
            //   fontWeight: FontWeight.w500,
            // ),
            // SizedBox(
            //   height: kDefaultPadding,
            // ),
            // BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
            //   builder: (context, state) {
            //     if (!state.imageBeforeInvalid) {
            //       return SelectImage(
            //         onPressedCancel: () {
            //           context
            //               .read<WorkerregisterworkBloc>()
            //               .add(WorkerregisterworkBeforeDeleteImage());
            //         },
            //         child: Container(
            //             child: Image(
            //                 fit: BoxFit.cover,
            //                 image: FileImage(
            //                   state.imageCMNDBefore,
            //                 ))),
            //       );
            //     }
            //     return DottedBorderCamara().ripple(() {
            //       context.read<WorkerregisterworkBloc>().add(
            //           WorkerregisterworkImageBeforeChanged(ImageSource.camera));
            //     });
            //   },
            // ),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
              builder: (context, state) {
                return PostSelectInput(
                  title: "Danh mục tin",
                  hintText: "Chưa có thông tin",
                  controler: new TextEditingController(text: state.serviceText),
                ).ripple(() {
                  Navigator.push(
                      context, SlideFadeRoute(page: WorkerSelectAddressPage()));
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
                  controler:
                      new TextEditingController(text: usestate.user.fullname),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            BlocBuilder<WorkerregisterworkBloc, WorkerregisterworkState>(
              builder: (context, state) {
                return //!state.imageAfterInvalid & !state.imageBeforeInvalid &&
                    state.serviceText.isNotEmpty
                        ? PostButton(
                            title: "Ứng tuyển ngay",
                            color: LightColor.lightteal,
                            textColor: Colors.white,
                            onPressed: () {
                              context
                                  .read<WorkerregisterworkBloc>()
                                  .add(WorkerregisterworkSubmitted());
                            },
                          )
                        : PostButton(
                            title: "Ứng tuyển ngay",
                            color: LightColor.lightteal,
                            textColor: Colors.black,
                            onPressed: null);
              },
            )
          ],
        ),
      ),
    );
  }
}

class SelectImage extends StatelessWidget {
  final Widget child;

  final Function onPressedCancel;
  const SelectImage({
    Key key,
    this.child,
    this.onPressedCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
            top: -10,
            right: -10,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
                size: 40,
              ),
            ).ripple(onPressedCancel)),
      ],
    );
  }
}

class DottedBorderCamara extends StatelessWidget {
  const DottedBorderCamara({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
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
    );
  }
}
