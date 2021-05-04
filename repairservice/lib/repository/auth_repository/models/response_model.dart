import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  final String status;
  final String message;
  final String type;

  ResponseModel({this.status, this.message, this.type});

  @override
  List<Object> get props => [status, message, type];
}
