import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String code;
  final String title;
  final String content;
  final String sendBy;
  final String sendPhone;
  final String receiveBy;
  final String receivephone;
  final String createAt;
  final int isReaded;
  final int type;
  final String postCode;
  final int statusAccept;
  final int sendByDelete;
  final int receiveByDelete;
  NotificationModel(
      {this.code,
      this.title,
      this.content,
      this.sendBy,
      this.createAt,
      this.isReaded,
      this.type,
      this.postCode,
      this.statusAccept,
      this.sendPhone,
      this.receiveBy,
      this.receivephone,
      this.sendByDelete,
      this.receiveByDelete});

  @override
  List<Object> get props => [
        code,
        title,
        content,
        sendBy,
        sendPhone,
        receiveBy,
        receivephone,
        createAt,
        isReaded,
        type,
        postCode,
        statusAccept,
        sendByDelete,
        receiveByDelete,
      ];

  NotificationModel copyWith({
    String code,
    String title,
    String content,
    String sendBy,
    String sendPhone,
    String receiveBy,
    String receivephone,
    String createAt,
    int isReaded,
    String postCode,
    int statusAccept,
    int type,
    int sendByDelete,
    int receiveByDelete,
  }) {
    return NotificationModel(
        code: code ?? this.code,
        title: title ?? this.title,
        content: content ?? this.content,
        sendBy: sendBy ?? this.sendBy,
        createAt: createAt ?? this.createAt,
        isReaded: isReaded ?? this.isReaded,
        postCode: postCode ?? this.postCode,
        statusAccept: statusAccept ?? this.statusAccept,
        type: type ?? this.type,
        sendPhone: sendPhone ?? this.sendPhone,
        receiveBy: receiveBy ?? this.receiveBy,
        receivephone: receivephone ?? this.receivephone,
        sendByDelete: sendByDelete ?? this.sendByDelete,
        receiveByDelete: receiveByDelete ?? this.receiveByDelete);
  }
}
