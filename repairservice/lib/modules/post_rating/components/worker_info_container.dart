import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';

class WorkerInfoContainer extends StatelessWidget {
  final ImageProvider<Object> imageUrl;
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
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                backgroundImage: imageUrl,
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
                // SizedBox(
                //   height: kDefaultPadding / 4,
                // ),
                // RichText(
                //     text: TextSpan(
                //         text: "Nghề nghiệp: $wofsText",
                //         style: TextStyle(
                //             color: LightColor.black,
                //             fontWeight: FontWeight.normal),
                //         children: [TextSpan(text: phone)])),
                // SizedBox(
                //   height: kDefaultPadding / 4,
                // ),
                // RichText(
                //     text: TextSpan(
                //         text: "Nghề nghiệp: ",
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.normal),
                //         children: [TextSpan(text: wofsText)])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
