part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure, loading }
enum PageStatus { initial, navigationPage }

class HomeState extends Equatable {
  const HomeState(
      {this.status = HomeStatus.initial,
      this.pagestatus = PageStatus.initial,
      this.services = const <Service>[],
      this.preferentials = const <Preferential>[],
      this.postRecently = const <Post>[],
      this.hasReachedMax = false,
      this.role,
      this.isCustomer,
      this.message});

  final HomeStatus status;
  final PageStatus pagestatus;
  final List<Service> services;
  final List<Preferential> preferentials;
  final List<Post> postRecently;
  final bool hasReachedMax;
  final int role;
  final UserType isCustomer;
  final String message;

  HomeState copyWith(
      {HomeStatus status,
      PageStatus pagestatus,
      List<Service> services,
      List<Preferential> preferentials,
      List<Post> postRecently,
      bool hasReachedMax,
      int role,
      UserType isCustomer,
      String message}) {
    return HomeState(
        status: status ?? this.status,
        pagestatus: pagestatus ?? this.pagestatus,
        services: services ?? this.services,
        preferentials: preferentials ?? this.preferentials,
        postRecently: postRecently ?? this.postRecently,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        role: role ?? this.role,
        isCustomer: isCustomer ?? this.isCustomer,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [
        status,
        pagestatus,
        services,
        postRecently,
        hasReachedMax,
        message,
        role,
        isCustomer
      ];
}

class HomeInitial extends HomeState {}
