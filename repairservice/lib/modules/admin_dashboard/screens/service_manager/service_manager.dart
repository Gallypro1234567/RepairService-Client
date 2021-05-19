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
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'bloc/servicemanager_bloc.dart';
import 'screens/service_detail_page.dart';
import '../../../../utils/ui/extensions.dart';

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
          title: Center(
            child: TitleText(
              text: 'Thêm mới',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: FormAddService(),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Button(
                    title: "Thoát",
                    color: Colors.red,
                    textColor: Colors.white,
                    icon: null,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Expanded(
                  child: BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
                    builder: (context, state) {
                      return Button(
                        title: "Thêm mới",
                        color: Colors.blue,
                        textColor: state.formzStatus.isValidated
                            ? Colors.white
                            : Colors.black,
                        icon: null,
                        onPressed: state.formzStatus.isValidated
                            ? () {
                                context
                                    .read<ServicemanagerBloc>()
                                    .add(ServicemanagerEventSubmited());
                                Navigator.of(context).pop();
                              }
                            : null,
                      );
                    },
                  ),
                ),
              ],
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
        toolbarHeight: AppTheme.fullHeight(context) * .06,
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
          if (state.formzStatus == FormzStatus.submissionSuccess) {
            context.read<ServicemanagerBloc>().add(ServicemanagerFetched());
            context.read<HomeBloc>().add(HomeFetched());
          }
        },
        child: BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
          builder: (context, state) {
            switch (state.status) {
              case ServiceManagerStatus.loading:
                return SplashPage();
              case ServiceManagerStatus.failure:
                return Center(
                  child: Text("Error"),
                );
              default:
                var datarows = state.services
                    .map((e) => DataRow(
                            onSelectChanged: (selected) {
                              if (selected) {
                                context
                                    .read<UpdateserviceBloc>()
                                    .add(UpdateserviceFetched(e.code));
                                Navigator.push(context,
                                    SlideFadeRoute(page: ServiceDetailPage()));
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
                              DataCell(Text(e.code)),
                              DataCell(Text(e.name)),
                              DataCell(Text(
                                e.wofsAmiount.toString(),
                                style: TextStyle(
                                    color: e.wofsAmiount == 0
                                        ? Colors.red
                                        : Colors.black),
                              )),
                              DataCell(Text(e.postAmount.toString(),
                                  style: TextStyle(
                                      color: e.postAmount == 0
                                          ? Colors.red
                                          : Colors.black))),
                              DataCell(Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 2),
                                child: Button(
                                  title: "Xóa",
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  onPressed: e.postAmount == 0 &&
                                          e.wofsAmiount == 0
                                      ? () {
                                          context
                                              .read<ServicemanagerBloc>()
                                              .add(ServiceManagerDeleteSubmited(
                                                  e.code));
                                        }
                                      : null,
                                ),
                              )),
                            ]))
                    .toList();
                return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<ServicemanagerBloc>()
                          .add(ServicemanagerFetched());
                    },
                    child: DataTableBloc(datarows: datarows));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ServicemanagerBloc>().add(ServicemanagerNew());
          _showMyDialog();
        },
        child: Icon(Entypo.plus),
      ),
    );
  }
}

class FormAddService extends StatelessWidget {
  const FormAddService({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Column(
            children: [
              Stack(
                children: [
                  BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
                    builder: (context, state) {
                      return SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundImage: !state.imageInvalid
                                ? FileImage(state.image)
                                : null,
                          ));
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2,
                            vertical: kDefaultPadding / 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        )).ripple(() {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => _BottomSheet(),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
            buildWhen: (previous, current) =>
                previous.servicename != current.servicename,
            builder: (context, state) {
              return PostFormInput(
                hintText: "Nhập tên dịch vụ",
                title: "Dịch vụ",
                invalid: state.servicename.invalid,
                errorText:
                    state.servicename.invalid ? "Không được trống" : null,
                onChanged: (value) {
                  context
                      .read<ServicemanagerBloc>()
                      .add(ServicemanagerNameChanged(value));
                },
              );
            },
          ),
          BlocBuilder<ServicemanagerBloc, ServicemanagerState>(
            buildWhen: (previous, current) =>
                previous.description != current.description,
            builder: (context, state) {
              return PostFormInput(
                hintText: "Mô tả",
                title: "Thông tin chi tiết",
                invalid: state.description.invalid,
                errorText:
                    state.description.invalid ? "Không được trống" : null,
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
            DataColumn(
              label: TitleText(
                text: 'Thợ',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: 'Tin đã đăng',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            DataColumn(
              label: TitleText(
                text: '',
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

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Chọn ảnh từ thư viện'),
          onPressed: () {
            context
                .read<ServicemanagerBloc>()
                .add(ServicemanagerImageChanged(ImageSource.gallery));
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Hủy'),
        onPressed: () {
          Navigator.pop(context);
        },
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
