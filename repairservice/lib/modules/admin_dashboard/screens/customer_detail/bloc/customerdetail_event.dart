part of 'customerdetail_bloc.dart';

abstract class CustomerdetailEvent extends Equatable {
  const CustomerdetailEvent();

  @override
  List<Object> get props => [];
}

class CustomerDetailInitital extends CustomerdetailEvent {}

class CustomerDetailFetched extends CustomerdetailEvent {
  final String phone;

  CustomerDetailFetched(this.phone);
}

class CustomerDetailFetchedPost extends CustomerdetailEvent {
  final String phone;

  CustomerDetailFetchedPost(this.phone);
}
class CustomerActionAcountSubtmitted extends CustomerdetailEvent {
  final int status; 
  CustomerActionAcountSubtmitted(this.status);
}