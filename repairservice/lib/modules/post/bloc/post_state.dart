part of 'post_bloc.dart';

enum PostStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum FileStatus { open, close }

class PostState extends Equatable {
  const PostState(
      {this.status = FormzStatus.pure,
      this.pageStatus = PostStatus.none,
      this.serviceText,
      this.serviceCode,
      this.name,
      this.address = const Address.pure(),
      this.title = const Title.pure(),
      this.description = const Description.pure(),
      this.posts = const <Post>[],
      this.images = const <File>[],
      this.fileStatus = FileStatus.close});

  final FormzStatus status;
  final PostStatus pageStatus;
  final String serviceText;
  final String serviceCode;
  final String name;
  final Address address;
  final Title title;
  final List<Post> posts;
  final Description description;

  final List<File> images;
  final FileStatus fileStatus;

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
        posts,
        images,
        fileStatus
      ];

  PostState copyWith(
      {FormzStatus status,
      PostStatus pageStatus,
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
      List<Post> posts,
      List<File> images,
      FileStatus fileStatus}) {
    return PostState(
      status: status ?? this.status,
      pageStatus: pageStatus ?? this.pageStatus,
      serviceText: serviceText ?? this.serviceText,
      serviceCode: serviceCode ?? this.serviceCode,
      name: name ?? this.name,
      title: title ?? this.title,
      address: address ?? this.address,
      posts: posts ?? this.posts,
      images: images ?? this.images,
      fileStatus: fileStatus ?? this.fileStatus,
      description: description ?? this.description,
    );
  }
}
