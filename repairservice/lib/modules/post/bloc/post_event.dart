part of 'post_bloc.dart';

class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostEvent {}

class PostRecently extends PostEvent {}

class PostFetched extends PostEvent {
  final String code;

  PostFetched(this.code);
}

class PostFetchedByPhone extends PostEvent {}

class PostServiceChanged extends PostEvent {
  final String text;
  final String code;
  PostServiceChanged({this.text, this.code});
}

class PostService extends PostEvent {
  final String value;

  PostService(this.value);
}

class PostAddressChanged extends PostEvent {
  final String value;

  PostAddressChanged(this.value);
}

class PostTitleChanged extends PostEvent {
  final String value;

  PostTitleChanged(this.value);
}

class PostDescriptionChanged extends PostEvent {
  final String value;

  PostDescriptionChanged(this.value);
}

class PostWorkerApplySubmitted extends PostEvent {
  final String code;

  PostWorkerApplySubmitted(this.code);
}

class PostCustomerSubmitted extends PostEvent {}
