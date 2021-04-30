import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/service_manager/bloc/servicemanager_bloc.dart';
import 'package:repairservice/modules/admin_dashboard/screens/service_manager/screens/bloc/updateservice_bloc.dart';
import 'package:repairservice/modules/admin_dashboard/screens/worker_register_manager/bloc/workerregistermanager_bloc.dart';
import 'package:repairservice/modules/admin_dashboard/screens/worker_register_manager/components/item_detail_container.dart';
import 'package:repairservice/modules/post/components/post_form_input.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../../../../utils/ui/extensions.dart';
import '../service_detail_page.dart';

class Content extends StatefulWidget {
  const Content({
    Key key,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _namecontroller = new TextEditingController();
  final _desciptioncontroller = new TextEditingController();
  Future<void> _showChangeNameDialog(name) async {
    _namecontroller.text = name;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: TitleText(
            text: 'Cập nhật thông tin',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
                  builder: (context, state) {
                    return PostFormInput(
                      hintText: "Nhập tên dịch vụ",
                      title: "Đổi tên",
                      controler: _namecontroller,
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
                  child: Text('Cập nhật'),
                  onPressed: () {
                    context
                        .read<UpdateserviceBloc>()
                        .add(UpdateserviceNameChanged(_namecontroller.text));
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

  Future<void> _showChangeDescriptionDialog(description) async {
    _desciptioncontroller.text = description;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: TitleText(
            text: 'Cập nhật thông tin',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
                  builder: (context, state) {
                    return PostFormInput(
                      hintText: "Chưa có mô tả",
                      title: "Thêm mô tả",
                      controler: _desciptioncontroller,
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
                  child: Text('Cập nhật'),
                  onPressed: () {
                    context.read<UpdateserviceBloc>().add(
                        UpdateserviceDescriptionChanged(
                            _desciptioncontroller.text));
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
    return Column(
      children: [
        BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
          builder: (context, state) {
            return ItemDetailContainer(
              title: "Mã đăng ký:",
              value: state.code,
            );
          },
        ),
        BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
          builder: (context, state) {
            return ItemDetailContainer(
              title: "Tên dịch vụ:",
              value: state.name,
            ).ripple(() {
              _showChangeNameDialog(state.name);
            });
          },
        ),
        BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
          builder: (context, state) {
            return ItemDetailContainer(
              title: "Mô tả:",
              value: state.description == null ? "" : state.description,
            ).ripple(() {
              _showChangeDescriptionDialog(state.description);
            });
          },
        ),
        BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
          builder: (context, state) {
            return ItemDetailContainer(
              title: "Thời gian tạo",
              value: state.createAt,
            );
          },
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
          builder: (context, state) {
            return WorkerRegisterButton(
              title: "Cập nhật",
              color: LightColor.red,
              colorActive: LightColor.lightteal,
              onPressed: () {
                context.read<UpdateserviceBloc>().add(UpdateserviceSubmited());
              },
            );
          },
        ),
      ],
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
