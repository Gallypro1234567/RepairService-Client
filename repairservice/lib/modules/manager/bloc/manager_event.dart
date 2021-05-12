part of 'manager_bloc.dart';

abstract class ManagerEvent extends Equatable {
  const ManagerEvent();

  @override
  List<Object> get props => [];
}

class ManagerFetched extends ManagerEvent {}

class ManagerCustomerDeletePost extends ManagerEvent {
  final String postCode;

  ManagerCustomerDeletePost(this.postCode);
}
class ManagerCustomerDeletePostApply extends ManagerEvent {
  final String postApplyCode;

  ManagerCustomerDeletePostApply(this.postApplyCode);
}
class ManagerWorkerDeleteApply extends ManagerEvent {
  final String postApplyCode;
  
  ManagerWorkerDeleteApply(this.postApplyCode);
}
