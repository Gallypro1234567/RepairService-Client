part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure, loading }

class HomeState extends Equatable {
  const HomeState(
      {this.status = HomeStatus.initial,
      this.services = const <Service>[],
      this.preferentials = const <Preferential>[],
      this.hasReachedMax = false,
      this.message});

  final HomeStatus status;
  final List<Service> services;
  final List<Preferential> preferentials;
  final bool hasReachedMax;
  final String message;

  HomeState copyWith(
      {HomeStatus status,
      List<Service> services,
      List<Preferential> preferentials,
      bool hasReachedMax,
      String message}) {
    return HomeState(
        status: status ?? this.status,
        services: services ?? this.services,
        preferentials: preferentials ?? this.preferentials,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        message: message ?? this.message);
  }

 
  @override
  List<Object> get props => [status, services, hasReachedMax, message];
}

class HomeInitial extends HomeState {}
