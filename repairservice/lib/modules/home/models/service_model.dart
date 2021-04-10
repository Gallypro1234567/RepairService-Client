import 'package:equatable/equatable.dart';

class Service extends Equatable {
  const Service({
    this.id,
    this.code,
    this.name,
  });
  final String id;
  final String code;
  final String name;

  @override
  List<Object> get props => [id, code, name];
}
