part of 'preferentialmanager_bloc.dart';

enum PreferentialManagerStatus { none, loading, success, failure }

class PreferentialmanagerState extends Equatable {
  const PreferentialmanagerState(
      {this.status = PreferentialManagerStatus.none,
      this.statusCode = 400,
      this.title,
      this.description,
      this.fromdate,
      this.todate,
      this.percent,
      this.image,
      this.imageUrl,
      this.servicecodes});

  final PreferentialManagerStatus status;
  final int statusCode;
  final String title;
  final String description;
  final String fromdate;
  final String todate;
  final String percent;
  final File image;
  final String imageUrl;
  final String servicecodes;
  @override
  List<Object> get props => [status,statusCode, title, description, fromdate, todate, percent, image, imageUrl, servicecodes];

  PreferentialmanagerState copyWith({
    PreferentialManagerStatus status,
    int statusCode,
    String title,
    String description,
    String fromdate,
    String todate,
    String percent,
    File image,
    String imageUrl,
    String servicecodes,
  }) {
    return PreferentialmanagerState(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      title: title ?? this.title,
      description: description ?? this.description,
      fromdate: fromdate ?? this.fromdate,
      todate: todate ?? this.todate,
      percent: percent ?? this.percent,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      servicecodes: servicecodes ?? this.servicecodes,
    );
  }
}
 