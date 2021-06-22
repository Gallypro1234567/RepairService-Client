import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/modules/admin_dashboard/screens/customer_detail/customer_detail_page.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';
import 'package:repairservice/repository/post_repository/models/post.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';

part 'customerdetail_event.dart';
part 'customerdetail_state.dart';

class CustomerdetailBloc
    extends Bloc<CustomerdetailEvent, CustomerdetailState> {
  CustomerdetailBloc({DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(CustomerdetailState());

  final DashboardRepository _dashboardRepository;
  @override
  Stream<CustomerdetailState> mapEventToState(
    CustomerdetailEvent event,
  ) async* {
    if (event is CustomerDetailInitital)
      yield state.copyWith();
    else if (event is CustomerDetailFetched)
      yield* _mapCustomerDetailFetchedToState(event, state);
    else if (event is CustomerActionAcountSubtmitted)
      yield* _mapCustomerActionAcountSubtmittedToState(event, state);
  }

  Stream<CustomerdetailState> _mapCustomerDetailFetchedToState(
      CustomerDetailFetched event, CustomerdetailState state) async* {
    yield state.copyWith(status: CustomerdetailStatus.loading);
    try {
      var detail = await _dashboardRepository.getInfoOfUser(phone: event.phone);
      if (detail.length > 0)
        yield state.copyWith(
            status: CustomerdetailStatus.success, detail: detail);
      else
        yield state.copyWith(
            status: CustomerdetailStatus.failure, detail: <UserDetail>[]);
    } on Exception catch (_) {
      yield state.copyWith(status: CustomerdetailStatus.failure);
    }
  }

  Stream<CustomerdetailState> _mapCustomerActionAcountSubtmittedToState(
      CustomerActionAcountSubtmitted event, CustomerdetailState state) async* {
    yield state.copyWith(status: CustomerdetailStatus.loading);
    try {
      var reponse = await _dashboardRepository.disableAccount(
          phone: state.detail.first.phone, status: event.status);

      if (reponse.statusCode == 200)
        yield state.copyWith(status: CustomerdetailStatus.submitted);
      else
        yield state.copyWith(
            status: CustomerdetailStatus.failure, detail: <UserDetail>[]);
    } on Exception catch (_) {
      yield state.copyWith(status: CustomerdetailStatus.failure);
    }
  }
}
