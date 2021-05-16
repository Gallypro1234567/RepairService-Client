part of 'postupdate_bloc.dart';

enum PostUpdateStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum FileStatus { open, close }
enum PositionUpdateStatus { loading, success, failure }

class PostUpdateState extends Equatable {
  const PostUpdateState(
      {this.status = FormzStatus.pure,
      this.pageStatus = PostUpdateStatus.none,
      this.positionUpdateStatus = PositionUpdateStatus.loading,
      this.serviceText,
      this.serviceCode,
      this.serviceInvalid = false,
      this.name,
      this.code,
      this.address = const Address.pure(),
      this.title = const Title.pure(),
      this.description = const Description.pure(),
      this.posts = const <Post>[],
      this.images = const <dynamic>[],
      this.imageUrls = const <String>[],
      this.fileStatus = FileStatus.close,
      //
      this.cityText = "",
      this.districtText = "",
      this.wardText = "",
      this.cityId,
      this.districtId,
      this.wardId,
      this.cityInvalid = false,
      this.districtInvalid = false,
      this.wardInvalid = false,
      this.cities = const <City>[],
      this.districts = const <District>[],
      this.wards = const <Ward>[]});

  final FormzStatus status;
  final PostUpdateStatus pageStatus;
  final PositionUpdateStatus positionUpdateStatus;
  final String serviceText;
  final String serviceCode;
  final bool serviceInvalid;
  final String name;
  final String code;
  final Address address;
  final Title title;
  final List<Post> posts;
  final Description description;
  final List<String> imageUrls;
  final List<dynamic> images;
  final FileStatus fileStatus;

  final String cityText;
  final String districtText;
  final String wardText;

  final int cityId;
  final int districtId;
  final int wardId;

  final bool cityInvalid;
  final bool districtInvalid;
  final bool wardInvalid;

  final List<City> cities;
  final List<District> districts;
  final List<Ward> wards;
  @override
  List<Object> get props => [
        status,
        pageStatus, positionUpdateStatus,
        serviceText,
        serviceCode, serviceInvalid,
        name,
        code,
        address,
        title,
        description,
        posts,
        images,
        imageUrls,
        fileStatus,
        //
        cityText,
        districtText,
        wardText,
        cityId,
        districtId,
        wardId,
        cityInvalid,
        wardInvalid,
        districtInvalid,
        cities,
        districts,
        wards
      ];

  PostUpdateState copyWith(
      {FormzStatus status,
      PostUpdateStatus pageStatus,
      PositionUpdateStatus positionUpdateStatus,
      String serviceText,
      String serviceCode,
      bool serviceInvalid,
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
      FileStatus fileStatus,
      //
      String cityText,
      String districtText,
      String wardText,
      int cityId,
      int districtId,
      int wardId,
      bool cityInvalid,
      bool districtInvalid,
      bool wardInvalid,
      List<City> cities,
      List<District> districts,
      List<Ward> wards}) {
    return PostUpdateState(
        status: status ?? this.status,
        pageStatus: pageStatus ?? this.pageStatus,
        positionUpdateStatus: positionUpdateStatus ?? this.positionUpdateStatus,
        serviceText: serviceText ?? this.serviceText,
        serviceCode: serviceCode ?? this.serviceCode,
        serviceInvalid: serviceInvalid ?? this.serviceInvalid,
        name: name ?? this.name,
        code: code ?? this.code,
        title: title ?? this.title,
        address: address ?? this.address,
        posts: posts ?? this.posts,
        images: images ?? this.images,
        fileStatus: fileStatus ?? this.fileStatus,
        imageUrls: imageUrls ?? this.imageUrls,
        description: description ?? this.description,
        //
        cityText: cityText ?? this.cityText,
        districtText: districtText ?? this.districtText,
        wardText: wardText ?? this.wardText,
        cityId: cityId ?? this.cityId,
        districtId: districtId ?? this.districtId,
        wardId: wardId ?? this.wardId,
        cityInvalid: cityInvalid ?? this.cityInvalid,
        districtInvalid: districtInvalid ?? this.districtInvalid,
        wardInvalid: wardInvalid ?? this.wardInvalid,
        cities: cities ?? this.cities,
        districts: districts ?? this.districts,
        wards: wards ?? this.wards);
  }
}
