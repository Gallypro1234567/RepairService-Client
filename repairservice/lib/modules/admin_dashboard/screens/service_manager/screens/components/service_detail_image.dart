import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/admin_dashboard/screens/service_manager/screens/bloc/updateservice_bloc.dart';
import 'package:repairservice/modules/splash/splash_page.dart';
import 'package:repairservice/widgets/title_text.dart';
import '../../../../../../utils/ui/extensions.dart';

class ServiceImage extends StatefulWidget {
  const ServiceImage({
    Key key,
  }) : super(key: key);

  @override
  _ServiceImageState createState() => _ServiceImageState();
}

class _ServiceImageState extends State<ServiceImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: kDefaultPadding / 2),
      height: AppTheme.fullHeight(context) * .2,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: LightColor.lightGrey, width: 1))),
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          SizedBox(
              height: 130,
              width: 130,
              child: Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
                  builder: (context, state) {
                    return CircleAvatar(
                      backgroundImage: state.fileStatus == FileStatus.open
                          ? FileImage(state.image)
                          : state.imageUrl.isNotEmpty
                              ? NetworkImage(state.imageUrl)
                              : null,
                    );
                  },
                ),
              )),
          Positioned(
              right: 0,
              bottom: 1,
              child: Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).showBottomSheet<void>(
                        (BuildContext context) {
                          return _BottomSheet();
                        },
                      );
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 30,
                    )),
              ))
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final Function camera;
  final Function gallery;
  const _BottomSheet({
    Key key,
    this.camera,
    this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: AppTheme.fullWidth(context),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: LightColor.lightteal,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: TitleText(
                          text: "Chọn ảnh",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
              builder: (context, state) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TitleText(
                            text: "Chụp từ Camera",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).ripple(() {
                  context
                      .read<UpdateserviceBloc>()
                      .add(UpdateserviceImageChanged(ImageSource.camera));
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<UpdateserviceBloc, UpdateserviceState>(
              builder: (context, state) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TitleText(
                            text: "Ảnh từ thư viện",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).ripple(() {
                  context
                      .read<UpdateserviceBloc>()
                      .add(UpdateserviceImageChanged(ImageSource.gallery));
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
