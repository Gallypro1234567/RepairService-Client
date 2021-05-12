part of 'postrate_bloc.dart';

enum PostRatingStatus {
  loading,
  success,
  submitted,
  failure,
  postted,
}

class PostrateState extends Equatable {
  const PostrateState(
      {this.workerRating,
      this.description,
      this.postcode,
      this.wofsCode,
      this.rating = 0,
      this.postDisable = false,
      this.feedbacks = const <FeedBack>[],
      this.status = PostRatingStatus.loading});
  final WorkerRate workerRating;
  final List<FeedBack> feedbacks;
  final String postcode;
  final String wofsCode;
  final PostRatingStatus status;
  final String description;
  final double rating;
  final bool postDisable;
  @override
  List<Object> get props => [
        status,
        postDisable,
        workerRating,
        description,
        rating,
        postcode,
        wofsCode,
        feedbacks
      ];

  PostrateState copyWith(
      {WorkerRate workerRating,
      PostRatingStatus status,
      String description,
      bool postDisable,
      double rating,
      String postcode,
      List<FeedBack> feedbacks,
      String wofsCode}) {
    return PostrateState(
        workerRating: workerRating ?? this.workerRating,
        status: status ?? this.status,
        description: description ?? this.description,
        postDisable: postDisable ?? this.postDisable,
        rating: rating ?? this.rating,
        wofsCode: wofsCode ?? this.wofsCode,
        feedbacks: feedbacks ?? this.feedbacks,
        postcode: postcode ?? this.postcode);
  }
}
