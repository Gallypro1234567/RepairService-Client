part of 'updateservice_bloc.dart';

enum UpdateServiceStatus { loading, success, failure, submitted }
enum FileStatus { open, close}

class UpdateserviceState extends Equatable {
  const UpdateserviceState(
      {this.status = UpdateServiceStatus.loading,
      this.code,
      this.createAt,
      this.name = "",
      this.description = "",
      this.image,
      this.imageUrl,
      this.fileStatus = FileStatus.close});

  final UpdateServiceStatus status;
  final String code;
  final String createAt;
  final String name;
  final String description;
  final File image; 
  final String imageUrl;
  final FileStatus fileStatus;
  @override
  List<Object> get props =>
      [status, name, description, image, code, createAt, imageUrl, fileStatus];

  UpdateserviceState copyWith(
      {UpdateServiceStatus status,
      String name,
      String description,
      File image,
      String code,
      String createAt,
      String imageUrl,
      FileStatus fileStatus}) {
    return UpdateserviceState(
        status: status ?? this.status,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        code: code ?? this.code,
        imageUrl: imageUrl ?? this.imageUrl,
        fileStatus: fileStatus ?? this.fileStatus,
        createAt: createAt ?? this.createAt);
  }
}
