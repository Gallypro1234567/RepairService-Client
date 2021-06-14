part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchEvent {}

class SearchFetched extends SearchEvent {
  final String code;
  final int cityId;
  final int districtId;
  final String search;
  SearchFetched({this.code, this.cityId, this.districtId, this.search});
}

class SearchCityFetched extends SearchEvent {}

class SearchCitySelectChanged extends SearchEvent {
  final String cityTitle;
  final int cityId;
  SearchCitySelectChanged({this.cityTitle, this.cityId});
}

class SearchDistrictFetched extends SearchEvent {
  final int cityId;
  SearchDistrictFetched(this.cityId);
}

class SearchDistrictSelectChanged extends SearchEvent {
  final String districtText;
  final int districtId;
  SearchDistrictSelectChanged({this.districtText, this.districtId});
}

class SearchWardFetched extends SearchEvent {
  final int districtId;
  final int provinceId;
  SearchWardFetched({this.districtId, this.provinceId});
}
