import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/modules/post_apply_detail/bloc/postapplydetail_bloc.dart';
import 'package:repairservice/modules/post_apply_detail/post_apply_detail_page.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/utils/ui/animations/slide_fade_route.dart';
import 'package:repairservice/widgets/title_text.dart';

import 'bloc/postapply_bloc.dart';
import 'components/post_apply_container.dart';
import 'components/post_apply_gridview.dart';
import '../../utils/ui/extensions.dart';

class PostApplyPage extends StatelessWidget {
  final String postCode;

  const PostApplyPage({Key key, this.postCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.lightGrey,
      appBar: AppBar(
        title: TitleText(
          text: "Danh sách thợ muốn thực hiện",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: LightColor.lightteal,
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<PostapplyBloc, PostapplyState>(
        builder: (context, state) {
          switch (state.status) {
            case ApplyStatus.loading:
              return SplashPage();
              break;
            case ApplyStatus.success:
              if (state.postApply.length == 0)
                return Center(
                  child: Text("Chưa có thông tin"),
                );
              return PostApplyGridView(
                length: state.postApply.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding / 4),
                    child: PostApplyContainer(
                            textColor: Colors.black,
                            backgroundColor: Colors.white,
                            postApply: state.postApply[index])
                        .ripple(() {
                      context.read<PostapplydetailBloc>().add(
                          PostApplyDetailFetched(
                              phone: state.postApply[index].phone,
                              postCode: postCode,
                              wofscode:
                                  state.postApply[index].workerOfServiceCode));
                      Navigator.push(context,
                          SlideFadeRoute(page: PostApplyWorkerDetailPage()));
                    }),
                  );
                },
              );
              break;
            case ApplyStatus.failure:
              return Center(
                child: Text("Error"),
              );
              break;
            default:
              return SplashPage();
              break;
          }
        },
      ),
    );
  }
}
