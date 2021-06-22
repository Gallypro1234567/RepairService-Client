part of 'search_bloc.dart';

enum SearchStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum SearchPositionStatus { loading, failure, success }

class SearchState extends Equatable {
  const SearchState(
      {this.pageStatus = SearchStatus.none,
      this.posts = const <Post>[],
      this.cities = const <City>[],
      this.distrists = const <District>[],
      this.wards = const <Ward>[],
      this.cityQuery = 'Toàn quốc',
      this.districtQuery = '',
      this.cityId = -1,
      this.districtId = -1,
      this.serviceCode = "",
      this.serviceText = "Tất cả",
      this.postGetPositionStatus,
      this.searchString = ""});
  final SearchStatus pageStatus;
  final List<Post> posts;
  final List<City> cities;
  final List<District> distrists;
  final List<Ward> wards;
  final String cityQuery;
  final String districtQuery;
  final int cityId;
  final int districtId;
  final String serviceCode;
  final String serviceText;
  final String searchString;
  final SearchPositionStatus postGetPositionStatus;
  @override
  List<Object> get props => [
        pageStatus,
        posts,
        cities,
        distrists,
        wards,
        cityQuery,
        districtQuery,
        cityId,
        districtId,
        serviceCode,
        serviceText,
        searchString,
        postGetPositionStatus
      ];

  SearchState copyWith(
      {SearchStatus pageStatus,
      List<Post> posts,
      List<City> cities,
      List<District> distrists,
      final String cityQuery,
      final String districtQuery,
      List<Ward> wards,
      int cityId,
      int districtId,
      String serviceCode,
      String serviceText,
      SearchPositionStatus postGetPositionStatus,
      String searchString}) {
    return SearchState(
        pageStatus: pageStatus ?? this.pageStatus,
        posts: posts ?? this.posts,
        cities: cities ?? this.cities,
        distrists: distrists ?? this.distrists,
        wards: wards ?? this.wards,
        cityQuery: cityQuery ?? this.cityQuery,
        districtQuery: districtQuery ?? this.districtQuery,
        cityId: cityId ?? this.cityId,
        districtId: districtId ?? this.districtId,
        serviceCode: serviceCode ?? this.serviceCode,
        serviceText: serviceText ?? this.serviceText,
        postGetPositionStatus:
            postGetPositionStatus ?? this.postGetPositionStatus,
        searchString: searchString ?? this.searchString);
  }
}
