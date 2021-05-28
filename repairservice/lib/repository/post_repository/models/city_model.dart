import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final String title;

  City({
    this.id,
    this.title,
  });
  @override
  List<Object> get props => [
        id,
        title,
      ];
}

class District extends Equatable {
  final int id;
  final String title;

  District({
    this.id,
    this.title,
  });
  @override
  List<Object> get props => [
        id,
        title,
      ];
}

class Ward extends Equatable {
  final int id;
  final String title;

  Ward({
    this.id,
    this.title,
  });

  @override
  List<Object> get props => [
        id,
        title,
      ];
}
