part of 'postfindworker_bloc.dart';

enum PageStatus { none, loading, success, failure }

class PostFindWorkerState extends Equatable {
  const PostFindWorkerState(
      {this.status = FormzStatus.pure,
      this.pageStatus = PageStatus.none,
      this.serviceCategory,
      this.serviceCategoryCode,
      this.name,
      this.city,
      this.cityCode,
      this.district,
      this.districtCode,
      this.title = const Title.pure(),
      this.description = const Description.pure()});

  final FormzStatus status;
  final PageStatus pageStatus;
  final String serviceCategory;
  final String serviceCategoryCode;
  final String name;
  final String city;
  final String cityCode;
  final String district;
  final String districtCode;
  final Title title;
  final Description description;

  @override
  List<Object> get props => [
        status,
        pageStatus,
        serviceCategory,
        serviceCategoryCode,
        name,
        city,
        cityCode,
        district,
        districtCode,
        title,
        description
      ];

  PostFindWorkerState copyWith({
    FormzStatus status,
    PageStatus pageStatus,
    String serviceCategory,
    String serviceCategoryCode,
    String name,
    String city,
    String cityCode,
    String district,
    String districtCode,
    Title title,
    Description description,
  }) {
    return PostFindWorkerState(
      status: status ?? this.status,
      pageStatus: pageStatus ?? this.pageStatus,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      serviceCategoryCode: serviceCategoryCode ?? this.serviceCategoryCode,
      name: name ?? this.name,
      city: city ?? this.city,
      cityCode: cityCode ?? this.cityCode,
      district: district ?? this.district,
      districtCode: districtCode ?? this.districtCode,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

 