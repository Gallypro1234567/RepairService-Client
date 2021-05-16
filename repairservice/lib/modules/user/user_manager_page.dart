import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';

import 'package:repairservice/core/user/login/bloc/login_bloc.dart';
import 'package:repairservice/modules/user_profile/bloc/userprofile_bloc.dart';
import 'package:repairservice/modules/user_profile/user_profile_page.dart';
import 'package:repairservice/modules/worker_history_work/bloc/workerregisterwork_bloc.dart';
import 'package:repairservice/modules/worker_history_work/user_history_work_screen.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../utils/ui/extensions.dart';
import 'bloc/user_bloc.dart';
import 'components/user_action_container.dart';
import 'components/user_avartar_container.dart';

class UserManagerPage extends StatefulWidget {
  @override
  _UserManagerPageState createState() => _UserManagerPageState();
}

class _UserManagerPageState extends State<UserManagerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {},
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          switch (state.status) {
            case UserStatus.loading:
              return const CircularProgressIndicator();
            case UserStatus.success:
              return UserWidget(state: state);
            default:
              return Center(
                child: Text("Error Loading data"),
              );
          }
        },
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  final UserState state;

  const UserWidget({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: TitleText(
          text: "Thông tin cá nhân",
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
        backgroundColor: LightColor.lightteal,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(color: LightColor.lightGrey),
        child: Column(
          children: [
            UserAvartarContainer(
              title: state.user.fullname,
              imageUrl: state.user.imageUrl != null ? state.user.imageUrl : "",
            ).ripple(() {
              context.read<UserProfileBloc>().add(UserProfileInitial());
              Navigator.push(context, SlideFadeRoute(page: UserProfilePage()));
            }),
            SizedBox(
              height: kDefaultPadding,
            ),
            state.user.isCustomer == UserType.customer
                ? Container()
                : UserActionContainer(
                    title: "Lịch sử công việc",
                  ).ripple(() {
                    context
                        .read<WorkerregisterworkBloc>()
                        .add(WorkerregisterworkServiceRegisterLoad());
                    Navigator.push(
                        context, SlideFadeRoute(page: WorkerHistoryWorkPage()));
                  }),
            SizedBox(
              height: kDefaultPadding / 5,
            ),
            UserActionContainer(
              title: "Lịch sử giao dịch",
            ).ripple(() {}),
            SizedBox(
              height: kDefaultPadding / 5,
            ),
            UserActionContainer(
              title: "Danh mục yêu thích",
            ).ripple(() {}),
            SizedBox(
              height: kDefaultPadding / 5,
            ),
            UserActionContainer(
              title: "Cài đặt",
            ).ripple(() {}),
            SizedBox(
              height: kDefaultPadding / 5,
            ),
            UserActionContainer(
              title: "Hỗ trợ ",
            ).ripple(() {}),
            SizedBox(
              height: kDefaultPadding / 5,
            ),
            _LogOutSubmitted(),
          ],
        ),
      ),
    );
  }
}

class _LogOutSubmitted extends StatelessWidget {
  const _LogOutSubmitted({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return UserActionContainer(
          title: "Đăng xuất ",
        ).ripple(() {
          context.read<LoginBloc>().add(LogOuttSubmitted());
        });
      },
    );
  }
}
