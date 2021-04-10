part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure, loading }

class HomeState extends Equatable {
  const HomeState(
      {this.status = HomeStatus.initial,
      this.services = const <Service>[],
      this.hasReachedMax = false,
      this.message});

  final HomeStatus status;
  final List<Service> services;
  final bool hasReachedMax;
  final String message;

  HomeState copyWith(
      {HomeStatus status,
      List<Service> services,
      bool hasReachedMax,
      String message}) {
    return HomeState(
        status: status ?? this.status,
        services: services ?? this.services,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        message: message ?? this.message);
  }

  @override
  String toString() {
    return '''HomeState { status: $status, hasReachedMax: $hasReachedMax, posts: ${services.length}, message: $message }''';
  }

  @override
  List<Object> get props => [status, services, hasReachedMax, message];
}

class HomeInitial extends HomeState {}
