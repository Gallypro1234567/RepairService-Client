part of 'post_bloc.dart';

enum PostStatus { none, loading, failure, loadSuccess, sbumitSuccess }
enum PositionStatus { none, loading, failure, success }
enum FileStatus { open, close }

class PostState extends Equatable {
  const PostState(
      {this.formzstatus = FormzStatus.pure,
      this.pageStatus = PostStatus.none,
      this.positionStatus = PositionStatus.loading,
      this.message,
      this.serviceText,
      this.serviceInvalid = false,
      this.serviceCode,
      this.name,
      this.address = const Address.pure(),
      this.title = const Title.pure(),
      this.description = const Description.pure(),
      this.images = const <File>[],
      this.fileStatus = FileStatus.close,
      this.cityText,
      this.districtText,
      this.wardText,
      this.cityId,
      this.districtId,
      this.wardId,
      this.cityInvalid = false,
      this.districtInvalid = false,
      this.wardInvalid = false,
      this.cities = const <City>[],
      this.districts = const <District>[],
      this.wards = const <Ward>[]});

  final FormzStatus formzstatus;
  final PostStatus pageStatus;
  final PositionStatus positionStatus;
  final String message;
  final String serviceText;
  final bool serviceInvalid;
  final String serviceCode;
  final String name;
  final Address address;
  final Title title;
  final Description description;
  final List<File> images;
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
        formzstatus,
        pageStatus,
        positionStatus,
        message,
        serviceText,
        serviceInvalid,
        serviceCode,
        name,
        address,
        title,
        description,
        images,
        fileStatus,
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

  PostState copyWith(
      {FormzStatus formzstatus,
      PostStatus pageStatus,
      PositionStatus positionStatus,
      String message,
      String serviceText,
      String serviceCode,
      bool serviceInvalid,
      String name,
      Title title,
      Address address,
      Description description,
      List<File> images,
      FileStatus fileStatus,
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
    return PostState(
        formzstatus: formzstatus ?? this.formzstatus,
        pageStatus: pageStatus ?? this.pageStatus,
        positionStatus: positionStatus ?? this.positionStatus,
        message: message ?? this.message,
        serviceText: serviceText ?? this.serviceText,
        serviceInvalid: serviceInvalid ?? this.serviceInvalid,
        serviceCode: serviceCode ?? this.serviceCode,
        name: name ?? this.name,
        title: title ?? this.title,
        address: address ?? this.address,
        images: images ?? this.images,
        fileStatus: fileStatus ?? this.fileStatus,
        description: description ?? this.description,
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
