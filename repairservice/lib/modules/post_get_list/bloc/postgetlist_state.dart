part of 'postgetlist_bloc.dart';

enum PostGetStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum PostGetPositionStatus { loading, failure, success }

class PostgetlistState extends Equatable {
  const PostgetlistState(
      {this.pageStatus = PostGetStatus.none,
      this.postGetPositionStatus = PostGetPositionStatus.loading,
      this.posts = const <Post>[],
      this.cities = const <City>[],
      this.distrists = const <District>[],
      this.wards = const <Ward>[],
      this.cityQuery = 'Toàn quốc',
      this.districtQuery = '',
      this.cityId = -1,
      this.districtId = -1,
      this.serviceCode});

  final PostGetStatus pageStatus;

  final List<Post> posts;
  final List<City> cities;
  final List<District> distrists;
  final List<Ward> wards;
  final String cityQuery;
  final String districtQuery;
  final int cityId;
  final int districtId;
  final String serviceCode;
  final PostGetPositionStatus postGetPositionStatus;
  @override
  List<Object> get props => [
        pageStatus,
        postGetPositionStatus,
        posts,
        cities,
        distrists,
        cityQuery,
        cityId,
        districtId,
        districtQuery,
        wards,
        serviceCode
      ];

  PostgetlistState copyWith(
      {PostGetStatus pageStatus,
      List<Post> posts,
      List<City> cities,
      List<District> distrists,
      final String cityQuery,
      final String districtQuery,
      List<Ward> wards,
      int cityId,
      int districtId,
      String serviceCode,
      PostGetPositionStatus postGetPositionStatus}) {
    return PostgetlistState(
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
        postGetPositionStatus:
            postGetPositionStatus ?? this.postGetPositionStatus);
  }
}
