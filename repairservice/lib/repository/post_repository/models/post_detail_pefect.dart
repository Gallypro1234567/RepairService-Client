import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

class PostPerfect extends Equatable {
  final String customerfullname;
  final String customerphone;
  final String customerAddress;

  final String workerfullname;
  final String workerphone;
  final String workerAddress;
  final String workerCMND;
  final String wofsCode;

  final String postCode;
  final String postTitle;
  final String serviceCode;
  final String serviceName;
  final int postStatus;
  final int applyStatus;
  final int feedbackStatus;
  PostPerfect(
      {this.customerfullname,
      this.customerphone,
      this.customerAddress,
      this.workerfullname,
      this.workerphone,
      this.workerAddress,
      this.workerCMND,
      this.wofsCode,
      this.postCode,
      this.postTitle,
      this.serviceCode,
      this.serviceName,
      this.feedbackStatus,
      this.postStatus,
      this.applyStatus});
  @override
  List<Object> get props => [
        customerfullname,
        customerphone,
        customerAddress,
        workerfullname,
        workerphone,
        workerAddress,
        workerCMND,
        postCode,
        wofsCode,
        postTitle,
        serviceCode,
        serviceName,
        feedbackStatus,
        postStatus,
        applyStatus
      ];
}
