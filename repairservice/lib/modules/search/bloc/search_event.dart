part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchEvent {}

class SearchFetched extends SearchEvent {}

class SearchChange extends SearchEvent {
  final String searhString;

  SearchChange({this.searhString});
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

class SearchServiceChanged extends SearchEvent {
  final String serviceCode;
  final String serviceText;
  SearchServiceChanged({
    this.serviceCode,
    this.serviceText,
  });
}
