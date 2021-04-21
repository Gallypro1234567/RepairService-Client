part of 'post_bloc.dart';

enum PageStatus { none, loading, success, failure, loadSuccess, sbumitSuccess }

class PostState extends Equatable {
  const PostState(
      {this.status = FormzStatus.pure,
      this.pageStatus = PageStatus.none,
      this.serviceText,
      this.serviceCode,
      this.name,
      this.address = const Address.pure(),
      this.title = const Title.pure(),
      this.description = const Description.pure(),
      this.posts = const <Post>[]});

  final FormzStatus status;
  final PageStatus pageStatus;
  final String serviceText;
  final String serviceCode;
  final String name;
  final Address address;
  final Title title;
  final List<Post> posts;
  final Description description;

  @override
  List<Object> get props => [
        status,
        pageStatus,
        serviceText,
        serviceCode,
        name,
        address,
        title,
        description,
        posts
      ];

  PostState copyWith(
      {FormzStatus status,
      PageStatus pageStatus,
      String serviceText,
      String serviceCode,
      String name,
      String city,
      String cityCode,
      String district,
      String districtCode,
      Title title,
      Address address,
      Description description,
      List<Post> posts}) {
    return PostState(
      status: status ?? this.status,
      pageStatus: pageStatus ?? this.pageStatus,
      serviceText: serviceText ?? this.serviceText,
      serviceCode: serviceCode ?? this.serviceCode,
      name: name ?? this.name,
      title: title ?? this.title,
      address: address ?? this.address,
      posts: posts ?? this.posts,
      description: description ?? this.description,
    );
  }
}
