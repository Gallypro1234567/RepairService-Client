part of 'post_bloc.dart';

enum PostStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum FileStatus { open, close }

class PostState extends Equatable {
  const PostState(
      {this.formzstatus = FormzStatus.pure,
      this.pageStatus = PostStatus.none,
      this.serviceText,
      this.serviceInvalid = false,
      this.serviceCode,
      this.name,
      this.address = const Address.pure(),
      this.title = const Title.pure(),
      this.description = const Description.pure(),
      this.images = const <File>[],
      this.fileStatus = FileStatus.close});

  final FormzStatus formzstatus;
  final PostStatus pageStatus;
  final String serviceText;
  final bool serviceInvalid;
  final String serviceCode;
  final String name;
  final Address address;
  final Title title;
  final Description description;
  final List<File> images;
  final FileStatus fileStatus;

  @override
  List<Object> get props => [
        formzstatus,
        pageStatus,
        serviceText,
        serviceInvalid,
        serviceCode,
        name,
        address,
        title,
        description,
        images,
        fileStatus
      ];

  PostState copyWith(
      {FormzStatus formzstatus,
      PostStatus pageStatus,
      String serviceText,
      String serviceCode,
      bool serviceInvalid,
      String name,
      String city,
      String cityCode,
      String district,
      String districtCode,
      Title title,
      Address address,
      Description description,
      List<File> images,
      FileStatus fileStatus}) {
    return PostState(
      formzstatus: formzstatus ?? this.formzstatus,
      pageStatus: pageStatus ?? this.pageStatus,
      serviceText: serviceText ?? this.serviceText,
      serviceInvalid: serviceInvalid ?? this.serviceInvalid,
      serviceCode: serviceCode ?? this.serviceCode,
      name: name ?? this.name,
      title: title ?? this.title,
      address: address ?? this.address,
      images: images ?? this.images,
      fileStatus: fileStatus ?? this.fileStatus,
      description: description ?? this.description,
    );
  }
}
