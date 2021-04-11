import 'package:equatable/equatable.dart';

class Preferential extends Equatable {
  final String code;
  final String title;
  final String description; 
  final String imageUrl;
  final String fromDate;
  final String toDate;
  final String percents;
  final String detail;

  Preferential({
    this.code,
    this.title,
    this.description,
    this.imageUrl,
    this.fromDate,
    this.toDate,
    this.percents,
    this.detail,
  });

  @override
  List<Object> get props =>
      [code, title, description, imageUrl, fromDate, toDate, percents];
}
