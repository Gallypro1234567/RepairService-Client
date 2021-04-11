import 'package:equatable/equatable.dart';

class Service extends Equatable {
  const Service({
    this.code,
    this.name,
    this.description,
    this.imageUrl,
    this.createAt,
  });
  final String code;
  final String name;
  final String description;
  final String imageUrl;
  final String createAt;

  @override
  List<Object> get props => [code, name, description, imageUrl, createAt];
}
