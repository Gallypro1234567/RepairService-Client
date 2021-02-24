import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import '../utils/ui/extensions.dart';

class UserCard extends StatefulWidget {
  final bool isActive;
  final VoidCallback press;
  final String username;

  const UserCard({Key key, this.isActive = false, this.press, this.username})
      : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        child: Container(
          decoration: BoxDecoration(
              color: widget.isActive ? kPrimaryColor : kBgDarkColor,
              borderRadius: BorderRadius.circular(10)),
          child: Material(
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  print('Hello World');
                },
                child: Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  // decoration: BoxDecoration(
                  //     color: isActive ? kPrimaryColor : kBgDarkColor,
                  //     borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage("assets/images/user_2.png"),
                            ),
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: "Xin chào \n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: widget.isActive
                                      ? Colors.white
                                      : kTextColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Hello',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: widget.isActive
                                              ? Colors.white
                                              : kTextColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).addNeumorphism(
                  blurRadius: 15,
                  borderRadius: 15,
                  offset: Offset(5, 5),
                  topShadowColor: Colors.white60,
                  bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
                )),
          ),
        ));
  }
}
