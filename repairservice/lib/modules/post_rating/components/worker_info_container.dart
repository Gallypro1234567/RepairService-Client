import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/utils/ui/reponsive.dart';

class WorkerInfoContainer extends StatelessWidget {
  final String imageUrl;
  final String fullname;
  final String phone;
  final String wofsText;
  const WorkerInfoContainer({
    Key key,
    this.imageUrl,
    this.fullname,
    this.phone,
    this.wofsText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Responsive.isTablet(context) ? 120 : 100,
                    width: Responsive.isTablet(context) ? 120 : 100,
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  // colorFilter: ColorFilter.mode(
                                  //     Colors.red, BlendMode.colorBurn),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/images/user_profile_background.jpg"),
                          ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: '${fullname.toUpperCase()} \n',
                      style: GoogleFonts.muli(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                            text: "SĐT: $phone \n",
                            style: GoogleFonts.muli(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )),
                        TextSpan(
                            text: "Nghề nghiệp: $wofsText",
                            style: GoogleFonts.muli(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ))
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
