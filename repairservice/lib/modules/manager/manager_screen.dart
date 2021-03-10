import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';

class ManagerScreen extends StatefulWidget {
  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  Map<DateTime, List<dynamic>> _events;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: TitleText(
            text: "Quản lý việc",
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Scaffold(
                appBar: TabBar(
                    indicator: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: LightColor.orange,
                        borderRadius: BorderRadius.circular(10)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today),
                            Text('Lịch'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.view_list),
                            Text('Danh sách'),
                          ],
                        ),
                      ),
                    ]),
                body: TabBarView(
                  children: [
                    Container(
                      height: AppTheme.fullWidth(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.purple),
                    ),
                    Container(
                      height: AppTheme.fullWidth(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
