import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repairservice/repository/post_repository/post_repository.dart';
import 'package:repairservice/repository/user_repository/user_model.dart';

part 'postrate_event.dart';
part 'postrate_state.dart';

class PostrateBloc extends Bloc<PostrateEvent, PostrateState> {
  PostrateBloc({PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostrateState());
  final PostRepository _postRepository;
  @override
  Stream<PostrateState> mapEventToState(
    PostrateEvent event,
  ) async* {
    if (event is PostrateInitial)
      yield state.copyWith();
    else if (event is PostrateFetched)
      yield* _mapPostrateFetchedToState(event, state);
    else if (event is PostrateRatingChanged)
      yield _mapPostrateRatingChangedToState(event, state);
    else if (event is PostrateDescriptionChanged)
      yield state.copyWith(description: event.description);
    else if (event is PostratePosted)
      yield* _mapPostratePostedToState(event, state);
  }

  _mapPostrateRatingChangedToState(
      PostrateRatingChanged event, PostrateState state) {
    if (event.rate == 0)
      return state.copyWith(rating: event.rate, postDisable: false);
    return state.copyWith(rating: event.rate, postDisable: true);
  }

  Stream<PostrateState> _mapPostrateFetchedToState(
      PostrateFetched event, PostrateState state) async* {
    yield state.copyWith(status: PostRatingStatus.loading);
    try {
      var detail = await _postRepository.fetchFeedbackReviewByWofSCode(
          wofscode: event.wofscode);
      List<FeedBack> feedbacks;
      if (event.postCode.isNotEmpty || event.postCode.length == 0)
        feedbacks = await _postRepository.fetchFeedbackByWofSCode(
            wofscode: event.wofscode, start: 0, length: 10);

      yield state.copyWith(
          status: PostRatingStatus.success,
          postcode: event.postCode,
          workerRating: detail,
          feedbacks: feedbacks,
          wofsCode: event.wofscode);
    } on Exception catch (_) {
      yield state.copyWith(status: PostRatingStatus.failure);
    }
  }

  Stream<PostrateState> _mapPostratePostedToState(
      PostratePosted event, PostrateState state) async* {
    yield state.copyWith(status: PostRatingStatus.loading);
    try {
      var response = await _postRepository.customerPostReviewRating(
          postcode: state.postcode,
          workerofservicecode: state.wofsCode,
          description: state.description,
          pointrating: state.rating);
      if (response.statusCode == 200) {
        await _postRepository.sendNotification(
            tilte: "Thông báo giao dịch",
            content: "đã hoàn tất đánh giá",
            receiveBy: state.workerRating.phone,
            postCode: state.postcode,
            status: 3,
            type: 1);
        yield state.copyWith(status: PostRatingStatus.submitted);
      } else
        yield state.copyWith(status: PostRatingStatus.failure);
    } on Exception catch (_) {
      yield state.copyWith(status: PostRatingStatus.failure);
    }
  }
}
