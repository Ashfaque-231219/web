part of 'schedule_bloc.dart';

class ScheduleState {
  final ScheduleModel? scheduleModel;
  final ViewScheduleModel? viewScheduleModel;
  final StateStatus viewStateStatus;
  final StateStatus stateStatus;

  ScheduleState({
    this.scheduleModel,
    this.viewScheduleModel,
    this.viewStateStatus = const StateNotLoaded(),
    this.stateStatus = const StateNotLoaded(),
  });

  ScheduleState copyWith({
    final ViewScheduleModel? viewScheduleModel,
    final StateStatus? viewStateStatus,
    final StateStatus? stateStatus,
  }) {
    return ScheduleState(
        scheduleModel: scheduleModel ?? scheduleModel,
        viewStateStatus: viewStateStatus ?? this.viewStateStatus,
        stateStatus: stateStatus ?? this.stateStatus,
        viewScheduleModel: viewScheduleModel ?? this.viewScheduleModel);
  }

  @override
  String toString() {
    return "scheduleModel:$scheduleModel,viewScheduleModel:$viewScheduleModel}";
  }
}
