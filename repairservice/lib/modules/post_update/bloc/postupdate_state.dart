part of 'postupdate_bloc.dart';

enum PostUpdateStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum FileStatus { open, close }

class PostUpdateState extends Equatable {
  const PostUpdateState(
      {this.status = FormzStatus.pure,
      this.pageStatus = PostUpdateStatus.none,
      this.serviceText,
      this.serviceCode,
      this.name,
      this.code,
      this.address = const Address.pure(),
      this.title = const Title.pure(),
      this.description = const Description.pure(),
      this.posts = const <Post>[],
      this.images = const <dynamic>[],
      this.imageUrls = const <String>[],
      this.fileStatus = FileStatus.close});

  final FormzStatus status;
  final PostUpdateStatus pageStatus;
  final String serviceText;
  final String serviceCode;
  final String name;
  final String code;
  final Address address;
  final Title title;
  final List<Post> posts;
  final Description description;
  final List<String> imageUrls;
  final List<dynamic> images;
  final FileStatus fileStatus;

  @override
  List<Object> get props => [
        status,
        pageStatus,
        serviceText,
        serviceCode,
        name,
        code,
        address,
        title,
        description,
        posts,
        images,
        imageUrls,
        fileStatus
      ];

  PostUpdateState copyWith(
      {FormzStatus status,
      PostUpdateStatus pageStatus,
      String serviceText,
      String serviceCode,
      String name,
      String code,
      String city,
      String cityCode,
      String district,
      String districtCode,
      Title title,
      Address address,
      Description description,
      List<Post> posts,
      List<dynamic> images,
      List<String> imageUrls,
      FileStatus fileStatus}) {
    return PostUpdateState(
      status: status ?? this.status,
      pageStatus: pageStatus ?? this.pageStatus,
      serviceText: serviceText ?? this.serviceText,
      serviceCode: serviceCode ?? this.serviceCode,
      name: name ?? this.name,
      code: code ?? this.code,
      title: title ?? this.title,
      address: address ?? this.address,
      posts: posts ?? this.posts,
      images: images ?? this.images,
      fileStatus: fileStatus ?? this.fileStatus,
      imageUrls: imageUrls ?? this.imageUrls,
      description: description ?? this.description,
    );
  }
}
