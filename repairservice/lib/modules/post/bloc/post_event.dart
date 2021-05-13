part of 'post_bloc.dart';

class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostEvent {}

class PostAddNewPage extends PostEvent {}

class PostAddImageMutiChanged extends PostEvent {
  final ImageSource imageSource;

  PostAddImageMutiChanged(this.imageSource);
}

class PostDeleteImageMutiChanged extends PostEvent {
  final int target;

  PostDeleteImageMutiChanged(this.target);
}

class PostFetchedByPhone extends PostEvent {}

class PostServiceChanged extends PostEvent {
  final String text;
  final String code;
  final bool invalid;
  PostServiceChanged({
    this.text,
    this.code,
    this.invalid,
  });
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
