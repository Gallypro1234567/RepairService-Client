import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String code;

  final String title;
  final String address;
  final String createAt;
  final String timePassed;
  final DateTime finishAt;
  final String imageUrl;
  final String customerImageUrl;
  final int districtId;
  final int cityId;
  final int wardId;
  final int status;
  final int applystatus;
  final String fullname;
  final String phone;
  final String email;
  final String desciption;
  final List<String> imageUrls;
  final String serviceCode;
  final String serviceText;
  final String wofsCode;
  Post(
      {this.code,
      this.title,
      this.address,
      this.createAt,
      this.timePassed,
      this.finishAt,
      this.imageUrl,
      this.customerImageUrl,
      this.districtId,
      this.cityId,
      this.wardId,
      this.status,
      this.applystatus,
      this.fullname,
      this.phone,
      this.desciption,
      this.email,
      this.imageUrls,
      this.serviceCode,
      this.wofsCode,
      this.serviceText});
  @override
  List<Object> get props => [
        code,
        title,
        address,
        createAt,
        timePassed,
        finishAt,
        imageUrl,
        customerImageUrl,
        districtId,
        cityId,
        wardId,
        status,
        applystatus,
        fullname,
        phone,
        desciption,
        email,
        imageUrls,
        serviceCode,
        serviceText,
        wofsCode
      ];
}

class PostApplyOfWorker extends Equatable {
  final String code;

  final String title;
  final String address;
  final String createAt;
  final String timePassed;
  final DateTime finishAt;
  final String imageUrl;
  final String customerImageUrl;
  final String fullname;
  final String phone;
  final String email;
  final String desciption;
  final List<String> imageUrls;
  final String serviceCode;
  final String serviceText;
  final String wofsCode;
  final int postStatus;
  final int applyStatus;
  PostApplyOfWorker(
      {this.code,
      this.title,
      this.address,
      this.createAt,
      this.timePassed,
      this.finishAt,
      this.imageUrl,
      this.customerImageUrl,
      this.postStatus,
      this.applyStatus,
      this.fullname,
      this.phone,
      this.desciption,
      this.email,
      this.imageUrls,
      this.serviceCode,
      this.wofsCode,
      this.serviceText});
  @override
  List<Object> get props => [
        code,
        title,
        address,
        createAt,
        timePassed,
        finishAt,
        imageUrl,
        customerImageUrl,
        postStatus,
        applyStatus,
        fullname,
        phone,
        desciption,
        email,
        imageUrls,
        serviceCode,
        serviceText,
        wofsCode
      ];
}
