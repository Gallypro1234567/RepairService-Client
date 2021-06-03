import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String code;
  final String title;
  final String content;
  final String sendBy;
  final String createAt;
  final int isReaded;
  final int type;
  NotificationModel({
    this.code,
    this.title,
    this.content,
    this.sendBy,
    this.createAt,
    this.isReaded,
    this.type,
  });

  @override
  List<Object> get props =>
      [code, title, content, sendBy, createAt, isReaded, type];

  NotificationModel copyWith(
      {String code,
      String title,
      String content,
      String sendBy,
      String createAt,
      bool isReaded,
      int type}) {
    return NotificationModel(
        code: code ?? this.code,
        title: title ?? this.title,
        content: content ?? this.content,
        sendBy: sendBy ?? this.sendBy,
        createAt: createAt ?? this.createAt,
        isReaded: isReaded ?? this.isReaded,
        type: type ?? this.type);
  }
}
