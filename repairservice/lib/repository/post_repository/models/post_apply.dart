import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/user_repository/models/user_enum.dart';

class WorkerApply extends Equatable {
  final String fullname;
  final String phone;
  final String email;
  final Sex sex;
  final String address;
  final String cmnd;
  final String imageUrl;
  final String workerOfServiceCode;
  final String serviceName;
  final String createAt;
  final int postStatus;
  final int status;
  WorkerApply(
      {this.fullname,
      this.phone,
      this.email,
      this.sex = Sex.empty,
      this.address,
      this.cmnd,
      this.imageUrl,
      this.workerOfServiceCode,
      this.status,
      this.createAt,
      this.postStatus,
      this.serviceName});
  @override
  List<Object> get props => [
        fullname,
        phone,
        email,
        sex,
        address,
        cmnd,
        imageUrl,
        workerOfServiceCode,
        status,
        serviceName,
        createAt,
        postStatus,
      ];
}
