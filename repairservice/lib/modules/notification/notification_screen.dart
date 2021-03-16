import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/widgets/title_text.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: TitleText(
            text: "Thông báo",
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
                      // borderRadius: BorderRadius.circular(10)
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today),
                            Text('Tin nhắn'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.view_list),
                            Text('Hộp thư'),
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
