part of 'postgetlist_bloc.dart';

enum PostGetStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum FileStatus { open, close }

class PostgetlistState extends Equatable {
  const PostgetlistState(
      {this.pageStatus = PostGetStatus.none,
      this.posts = const <Post>[],
      this.cities = const <City>[],
      this.distrists = const <District>[],
      this.wards = const <Ward>[],
      this.cityQuery = 'Toàn quốc',
      this.districtQuery= ''});

  final PostGetStatus pageStatus;

  final List<Post> posts;
  final List<City> cities;
  final List<District> distrists;
  final List<Ward> wards;
  final String cityQuery;
  final String districtQuery;

  @override
  List<Object> get props => [
        pageStatus,
        posts,
        cities,
        distrists,
        cityQuery,
        districtQuery,
        wards,
      ];

  PostgetlistState copyWith(
      {PostGetStatus pageStatus,
      List<Post> posts,
      List<City> cities,
      List<District> distrists,
      final String cityQuery,
      final String districtQuery,
      List<Ward> wards}) {
    return PostgetlistState(
      pageStatus: pageStatus ?? this.pageStatus,
      posts: posts ?? this.posts,
      cities: cities ?? this.cities,
      distrists: distrists ?? this.distrists,
      wards: wards ?? this.wards,
      cityQuery: cityQuery ?? this.cityQuery,
      districtQuery: districtQuery ?? this.districtQuery,
    );
  }
}
