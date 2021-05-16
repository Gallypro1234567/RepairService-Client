part of 'postupdate_bloc.dart';

class PostUpdateEvent extends Equatable {
  const PostUpdateEvent();

  @override
  List<Object> get props => [];
}

class PostUpdateInitial extends PostUpdateEvent {}

class PostUpdateAddNewPage extends PostUpdateEvent {}

class PostUpdateRecently extends PostUpdateEvent {}

class PostUpdateFetched extends PostUpdateEvent {
  final String code;

  PostUpdateFetched(this.code);
}

class PostUpdateCityFetched extends PostUpdateEvent {}

class PostUpdateDistrictFetched extends PostUpdateEvent {
  final int cityid;

  PostUpdateDistrictFetched(this.cityid);
}

class PostUpdateWardFetched extends PostUpdateEvent {
  final int districtId;

  PostUpdateWardFetched(this.districtId);
}

class PostUpdateCityChanged extends PostUpdateEvent {
  final String text;
  final int id;
  final bool invalid;
  PostUpdateCityChanged({this.text, this.invalid, this.id});
}

class PostUpdateDistrictChanged extends PostUpdateEvent {
  final String text;
  final int id;
  final bool invalid;
  PostUpdateDistrictChanged({this.text, this.invalid, this.id});
}

class PostUpdateWardChanged extends PostUpdateEvent {
  final String text;
  final int id;
  final bool invalid;
  PostUpdateWardChanged({this.text, this.invalid, this.id});
}

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
  final bool invalid;
  PostUpdateServiceChanged({this.text, this.invalid, this.code});
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
