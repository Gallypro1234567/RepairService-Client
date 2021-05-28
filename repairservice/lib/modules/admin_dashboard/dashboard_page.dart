import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/service_manager/service_manager.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:repairservice/core/user/login/bloc/login_bloc.dart';
import 'screens/customer_manager/customer_manager.dart';
import 'screens/post_manager/bloc/postmanager_bloc.dart';
import 'screens/post_manager/post_manager_page.dart';
import 'screens/service_manager/bloc/servicemanager_bloc.dart';
import 'screens/worker_manager.dart/worker_manager.dart';
import 'screens/worker_register_manager/worker_register_manager.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Set the transparency here
        canvasColor: Colors
            .white, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
      ),
      child: Drawer(
        child: Container(
          child: ListView(
            children: [
              Header(),
              ListTile(
                leading: Icon(Icons.design_services),
                title: TitleText(
                  text: 'Quản lý dịch vụ',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  context
                      .read<ServicemanagerBloc>()
                      .add(ServicemanagerFetched());
                  Navigator.push(
                      context, SlideFadeRoute(page: ServiceManagerPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: TitleText(
                  text: 'Quản lý thợ',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  Navigator.push(
                      context, SlideFadeRoute(page: WorkerManagerPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: TitleText(
                  text: 'Quản lý khách hàng',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  Navigator.push(
                      context, SlideFadeRoute(page: CustomerManagerPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.app_registration),
                title: TitleText(
                  text: 'Danh sách thợ đăng ký',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  Navigator.push(context,
                      SlideFadeRoute(page: WorkerRegisterManagerPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.app_registration),
                title: TitleText(
                  text: 'Danh sách tin',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  context.read<PostmanagerBloc>().add(PostmanagerFetched());
                  Navigator.push(
                      context, SlideFadeRoute(page: PostmanagerPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(state.user.imageUrl)),
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              TitleText(
                text: state.user.fullname,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              TitleText(
                text: state.user.email,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Button(
                title: "Đăng xuất",
                onPressed: () {
                  context.read<LoginBloc>().add(LogOuttSubmitted());
                },
                color: LightColor.lightteal,
              )
            ],
          ),
        );
      },
    );
  }
}

class Button extends StatelessWidget {
  final title;
  final Function onPressed;
  final Color color;
  final Color textColor;
  const Button({
    Key key,
    this.title,
    this.onPressed,
    this.color,
    this.textColor = Colors.white,
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
            width: AppTheme.fullWidth(context) * 0.5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: TitleText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor))),
      ),
      onPressed: onPressed,
    );
  }
}
