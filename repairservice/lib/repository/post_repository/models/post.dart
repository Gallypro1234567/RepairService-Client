import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String code;
  final String title;
  final String address;
  final DateTime createAt;
  final DateTime finishAt;
  final String imageUrl;
  final String position;
  final int status;
  final String fullname;
  final String phone;
  final String email;

  Post(
      {this.code,
      this.title,
      this.address,
      this.createAt,
      this.finishAt,
      this.imageUrl,
      this.position,
      this.status,
      this.fullname,
      this.phone,
      this.email});
  @override
  List<Object> get props => [
        code,
        title,
        address,
        createAt,
        finishAt,
        imageUrl,
        position,
        status,
        fullname,
        phone,
        email
      ];
}
