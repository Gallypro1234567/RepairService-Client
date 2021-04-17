part of 'postfindworker_bloc.dart';

class PostFindWorkerEvent extends Equatable {
  const PostFindWorkerEvent();

  @override
  List<Object> get props => [];
}

class PostFindWorkerInitial extends PostFindWorkerEvent {}

class PostFindWorkerServiceChanged extends PostFindWorkerEvent {
  final String text;
  final String code;
  PostFindWorkerServiceChanged({this.text, this.code});
}

class PostFindWorkerCityChanged extends PostFindWorkerEvent {
  final String value;

  PostFindWorkerCityChanged(this.value);
}

class PostFindWorkerDistrictChanged extends PostFindWorkerEvent {
  final String value;

  PostFindWorkerDistrictChanged(this.value);
}

class PostFindWorkerService extends PostFindWorkerEvent {
  final String value;

  PostFindWorkerService(this.value);
}

class PostFindWorkerCity extends PostFindWorkerEvent {
  final String value;

  PostFindWorkerCity(this.value);
}

class PostFindWorkerDistrict extends PostFindWorkerEvent {
  final String value;

  PostFindWorkerDistrict(this.value);
}

class PostFindWorkerTitle extends PostFindWorkerEvent {
  final String value;

  PostFindWorkerTitle(this.value);
}

class PostFindWorkerSubmitted extends PostFindWorkerEvent {}
