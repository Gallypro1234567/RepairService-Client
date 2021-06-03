part of 'notification_bloc.dart';

enum NotificationStatus {
  none,
  loading,
  selectPage,
  success,
  refeshed,
  failure,
  submittedSuccess
}
typedef RemovedItemBuilder = Function(
    int item, BuildContext context, Animation<double> animation);

class NotificationState extends Equatable {
  const NotificationState(
      {this.status = NotificationStatus.none,
      this.pageActive = -1,
      this.notifiAll = const <NotificationModel>[],
      this.notifiperson = const <NotificationModel>[],
      this.notifiadmin = const <NotificationModel>[],
      this.checkAdmin = 0,
      this.checkperson = 0,
      this.checkall = 0});
  final NotificationStatus status;
  final int pageActive;
  final List<NotificationModel> notifiadmin;
  final List<NotificationModel> notifiperson;
  final List<NotificationModel> notifiAll;
  final int checkAdmin;
  final int checkperson;
  final int checkall;

  @override
  List<Object> get props => [
        status,
        notifiAll,
        pageActive,
        notifiadmin,
        notifiperson,
        checkall,
        checkperson,
        checkAdmin
      ];

  NotificationState copyWith(
      {NotificationStatus status,
      List<NotificationModel> notifiAll,
      List<NotificationModel> notifiadmin,
      List<NotificationModel> notifiperson,
      int pageActive,
      final int checkAdmin,
      final int checkperson,
      final int checkall}) {
    return NotificationState(
        status: status ?? this.status,
        notifiAll: notifiAll ?? this.notifiAll,
        notifiadmin: notifiadmin ?? this.notifiadmin,
        notifiperson: notifiperson ?? this.notifiperson,
        pageActive: pageActive ?? this.pageActive,
        checkAdmin: checkAdmin ?? this.checkAdmin,
        checkperson: checkperson ?? this.checkperson,
        checkall: checkall ?? this.checkall);
  }
}
