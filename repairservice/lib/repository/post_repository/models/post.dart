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
  final String position;
  final int status;
  final String fullname;
  final String phone;
  final String email;
  final String desciption;
  final List<String> imageUrls;
  final String serviceCode;
  final String serviceText;
  Post(
      {this.code,
      this.title,
      this.address,
      this.createAt,
      this.timePassed,
      this.finishAt,
      this.imageUrl,
      this.customerImageUrl,
      this.position,
      this.status,
      this.fullname,
      this.phone,
      this.desciption,
      this.email,
      this.imageUrls,
      this.serviceCode,
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
        position,
        status,
        fullname,
        phone,
        desciption,
        email,
        imageUrls,
        serviceCode,
        serviceText
      ];
}
