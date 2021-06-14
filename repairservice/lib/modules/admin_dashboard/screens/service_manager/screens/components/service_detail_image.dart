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
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => _BottomSheet(),
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
  const _BottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Chọn ảnh từ thư viện'),
          onPressed: () {
            context
                .read<UpdateserviceBloc>()
                .add(UpdateserviceImageChanged(ImageSource.gallery));
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Chụp hình'),
          onPressed: () {
            context
                .read<UpdateserviceBloc>()
                .add(UpdateserviceImageChanged(ImageSource.camera));
            Navigator.pop(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Hủy'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
