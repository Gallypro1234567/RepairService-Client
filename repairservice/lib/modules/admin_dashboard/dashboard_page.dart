import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/modules/admin_dashboard/screens/service_manager/service_manager.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'screens/customer_manager/customer_manager.dart';
import 'screens/worker_manager.dart/worker_manager.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: TitleText(
                text: "Admin",
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            decoration: BoxDecoration(
              color: LightColor.lightteal,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Quản lý dịch vụ'),
            onTap: () {
              Navigator.push(
                  context, SlideFadeRoute(page: ServiceManagerPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Danh sách thợ đăng ký'),
            onTap: () {
              Navigator.push(
                  context, SlideFadeRoute(page: ServiceManagerPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Quản lý khách hàng'),
            onTap: () {
              Navigator.push(
                  context, SlideFadeRoute(page: CustomerManagerPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Quản lý thợ'),
            onTap: () {
              Navigator.push(
                  context, SlideFadeRoute(page: WorkerManagerPage()));
            },
          ),
        ],
      ),
    );
  }
}
