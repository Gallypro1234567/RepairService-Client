import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/core/auth/bloc/authentication_bloc.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

import 'notification_customer_page.dart';
import 'notification_worker_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        switch (state.user.isCustomer) {
          case UserType.worker:
            return NotificationWorkerPage();
            break;
          default:
            return NotificationCustomerPage();
        }
      },
    );
  }
}
