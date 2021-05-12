import 'dart:async'; 
import 'dart:io'; 
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart'; 
import 'package:image_picker/image_picker.dart';
import 'package:repairservice/repository/dashboard_repository/dashboard_repository.dart';

part 'updateservice_event.dart';
part 'updateservice_state.dart';

class UpdateserviceBloc extends Bloc<UpdateserviceEvent, UpdateserviceState> {
  UpdateserviceBloc({DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(UpdateserviceState());
  final DashboardRepository _dashboardRepository;
  @override
  Stream<UpdateserviceState> mapEventToState(
    UpdateserviceEvent event,
  ) async* {
    if (event is UpdateserviceInitial) {
      yield state.copyWith();
    } else if (event is UpdateserviceFetched) {
      yield* _mapUpdateserviceFetchedToState(event, state);
    } else if (event is UpdateserviceNameChanged) {
      yield state.copyWith(name: event.value);
    } else if (event is UpdateserviceDescriptionChanged) {
      yield state.copyWith(description: event.value);
    } else if (event is UpdateserviceImageChanged) {
      yield* _mapUpdateserviceImageChangedToState(event, state);
    } else if (event is UpdateserviceSubmited) {
      yield* _mapUpdateserviceSubmitedToState(event, state);
    }
  }

  Stream<UpdateserviceState> _mapUpdateserviceImageChangedToState(
      UpdateserviceImageChanged event, UpdateserviceState state) async* {
    yield state.copyWith(fileStatus: FileStatus.close);
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: event.imageSource);
      if (pickedFile != null) {
        yield state.copyWith(
            image: File(pickedFile.path), fileStatus: FileStatus.open);
      } else {
        yield state.copyWith(
          image: null,
        );
      }
    } on Exception catch (_) {
      yield state.copyWith(fileStatus: FileStatus.close);
    }
  }

  Stream<UpdateserviceState> _mapUpdateserviceFetchedToState(
      UpdateserviceFetched event, UpdateserviceState state) async* {
    yield state.copyWith(status: UpdateServiceStatus.loading);

    try {
      var service = await _dashboardRepository.fetchServiceDetail(event.code);

      yield state.copyWith(
          image: null,
          status: UpdateServiceStatus.success,
          name: service.name,
          code: service.code,
          createAt: service.createAt,
          description: service.description,
          imageUrl: service.imageUrl == null ? "" : service.imageUrl,
          fileStatus: FileStatus.close);
    } on Exception catch (_) {
      yield state.copyWith(status: UpdateServiceStatus.failure);
    }
  }

  Stream<UpdateserviceState> _mapUpdateserviceSubmitedToState(
      UpdateserviceSubmited event, UpdateserviceState state) async* {
    yield state.copyWith(status: UpdateServiceStatus.loading);
    try {
      var response = await _dashboardRepository.updateService(
          code: state.code,
          description: state.description,
          name: state.name,
          file: state.image);
      if (response.statusCode == 200) {
        yield state.copyWith(
          status: UpdateServiceStatus.submitted,
        );
      } else {
        yield state.copyWith(
          status: UpdateServiceStatus.failure,
        );
      }
    } on Exception catch (_) {
      yield state.copyWith(status: UpdateServiceStatus.failure);
    }
  }
}
