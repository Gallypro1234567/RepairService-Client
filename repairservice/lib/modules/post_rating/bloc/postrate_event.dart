part of 'postrate_bloc.dart';

abstract class PostrateEvent extends Equatable {
  const PostrateEvent();

  @override
  List<Object> get props => [];
}

class PostrateInitial extends PostrateEvent {}

class PostrateFetched extends PostrateEvent {
  final String wofscode;
  final String postCode;
  PostrateFetched({this.wofscode, this.postCode});
}

class PostrateRatingChanged extends PostrateEvent {
  final double rate;

  PostrateRatingChanged(this.rate);
}

class PostrateDescriptionChanged extends PostrateEvent {
  final String description;

  PostrateDescriptionChanged(this.description);
}

class PostratePosted extends PostrateEvent {}
