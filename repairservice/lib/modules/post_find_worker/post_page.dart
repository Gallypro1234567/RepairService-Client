import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/post_find_worker/screens/select_address.dart';
import 'package:repairservice/modules/user/bloc/user_bloc.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

 
import 'components/post_button.dart';
import 'components/post_form_input.dart';
 
import '../../utils/ui/extensions.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Chọn danh mục bài viết",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding),
          child: Column(
            children: [
              DottedBorder(
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
                          color: Colors.amber,
                          size: 100,
                        ),
                        TitleText(
                          text: "Chọn ảnh",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              PostFormInput(
                title: "Danh mục tin",
                hintText: "Chưa có thông tin",
              ).ripple(() {
                Navigator.push(
                    context, SlideFadeRoute(page: SelectAddressPage()));
              }),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, usestate) {
                  return PostFormInput(
                    title: "Bạn là",
                    hintText: usestate.user.fullname,
                  );
                },
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              PostFormInput(
                title: "Chọn tỉnh, thành phố",
                hintText: "Chưa có thông tin",
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              PostFormInput(
                title: "Chọn quận, huyện",
                hintText: "Chưa có thông tin",
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              PostFormInput(
                title: "Tiêu đề",
                hintText: "Chưa có thông tin",
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              PostButton(
                title: "Đăng tin ngay",
                color: LightColor.orange,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
