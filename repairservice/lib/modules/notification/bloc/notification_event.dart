part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationEvent {}
class NotificationOnSelect extends NotificationEvent {
    final int select;

  NotificationOnSelect(this.select);
}
class NotificationFetched extends NotificationEvent {
    final int type;

  NotificationFetched(this.type);
}

class NotificationRefeshed extends NotificationEvent {
  final int type;

  NotificationRefeshed(this.type);
}

class NotificationSubmitted extends NotificationEvent {
  final String code;
  final int type;

  NotificationSubmitted({this.code, this.type});
}
