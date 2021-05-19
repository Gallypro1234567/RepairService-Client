import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repairservice/config/themes/constants.dart';

class SlidableContainer extends StatelessWidget {
  final Widget child;
  final Function onPressedDelete;
  final Function onPressedDetail;
  final Function onPressedCall;
  final bool isDelete;
  final bool isCall;
  const SlidableContainer({
    Key key,
    this.child,
    this.onPressedDelete,
    this.onPressedDetail,
    this.isDelete = false,
    this.isCall = false,
    this.onPressedCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: isDelete
          ? <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding / 6),
                child: IconSlideAction(
                  caption: 'Chi tiết',
                  color: Colors.blue,
                  icon: Icons.more_vert,
                  onTap: onPressedDetail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding / 6),
                child: IconSlideAction(
                  caption: 'Xóa',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: onPressedDelete,
                ),
              ),
            ]
          : <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding / 6),
                child: IconSlideAction(
                  caption: 'Chi tiết',
                  color: Colors.blue,
                  icon: Icons.more_vert,
                  onTap: onPressedDetail,
                ),
              ),
            ],
      actions: isCall
          ? <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding / 6),
                child: IconSlideAction(
                  caption: 'Gọi khách',
                  color: Colors.green,
                  icon: Icons.call,
                  onTap: onPressedCall,
                ),
              ),
            ]
          : [],
      child: child,
    );
  }
}
