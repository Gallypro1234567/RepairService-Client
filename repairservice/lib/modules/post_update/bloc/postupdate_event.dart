part of 'postupdate_bloc.dart';

class PostUpdateEvent extends Equatable {
  const PostUpdateEvent();

  @override
  List<Object> get props => [];
}

class PostUpdateInitial extends PostUpdateEvent {}

class PostUpdateRecently extends PostUpdateEvent {}

class PostUpdateFetched extends PostUpdateEvent {
  final String code;

  PostUpdateFetched(this.code);
}
class PostUpdateAddNewPage extends PostUpdateEvent {}
class PostUpdateAddImageMutiChanged extends PostUpdateEvent {
  final ImageSource imageSource;

  PostUpdateAddImageMutiChanged(this.imageSource);
}

class PostUpdateDeleteImageMutiChanged extends PostUpdateEvent {
  final int target;

  PostUpdateDeleteImageMutiChanged(this.target);
}

class PostUpdateFetchedByPhone extends PostUpdateEvent {}

class PostUpdateServiceChanged extends PostUpdateEvent {
  final String text;
  final String code;
  PostUpdateServiceChanged({this.text, this.code});
}

class PostUpdateService extends PostUpdateEvent {
  final String value;

  PostUpdateService(this.value);
}

class PostUpdateAddressChanged extends PostUpdateEvent {
  final String value;

  PostUpdateAddressChanged(this.value);
}

class PostUpdateTitleChanged extends PostUpdateEvent {
  final String value;

  PostUpdateTitleChanged(this.value);
}

class PostUpdateDescriptionChanged extends PostUpdateEvent {
  final String value;

  PostUpdateDescriptionChanged(this.value);
}

class PostUpdateWorkerApplySubmitted extends PostUpdateEvent {
  final String code;

  PostUpdateWorkerApplySubmitted(this.code);
}

class PostUpdateCustomerSubmitted extends PostUpdateEvent {}
