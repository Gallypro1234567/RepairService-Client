import 'package:flutter/cupertino.dart';
import 'package:repairservice/modules/user/components/user_action_container.dart';

class UserActionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserActionContainer(
          title: "Lịch sử công việc",
        ),
        UserActionContainer(
          title: "Lịch sử giao dịch",
        ),
        UserActionContainer(
          title: "Danh mục yêu thích",
        ),
        UserActionContainer(
          title: "Cài đặt",
        ),
        UserActionContainer(
          title: "Hỗ trợ ",
        ),
      ],
    );
  }
}
