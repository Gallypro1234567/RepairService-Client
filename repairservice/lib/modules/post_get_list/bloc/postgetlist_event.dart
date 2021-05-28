part of 'postgetlist_bloc.dart';

abstract class PostgetlistEvent extends Equatable {
  const PostgetlistEvent();

  @override
  List<Object> get props => [];
}

class PostgetlistInitial extends PostgetlistEvent {}

class PostgetlistFetched extends PostgetlistEvent {
  final String code;
  final int cityId;
  final int districtId;
  PostgetlistFetched({this.code, this.cityId, this.districtId});
}

class PostgetlistCityFetched extends PostgetlistEvent {}

class PostgetlistCitySelectChanged extends PostgetlistEvent {
  final String cityTitle;
  final int cityId;
  PostgetlistCitySelectChanged({this.cityTitle, this.cityId});
}

class PostgetlistDistrictFetched extends PostgetlistEvent {
  final int cityId;
  PostgetlistDistrictFetched(this.cityId);
}

class PostgetlistDistrictSelectChanged extends PostgetlistEvent {
  final String districtText;
  final int districtId;
  PostgetlistDistrictSelectChanged({this.districtText, this.districtId});
}

class PostgetlistWardFetched extends PostgetlistEvent {
  final int districtId;
  final int provinceId;
  PostgetlistWardFetched({this.districtId, this.provinceId});
}
