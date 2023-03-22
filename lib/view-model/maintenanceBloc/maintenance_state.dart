part of 'maintenance_bloc.dart';

class MaintenanceState {
  final MaintenanceModel? maintenanceModel;
  final StateStatus stateStatus;

  MaintenanceState({this.maintenanceModel, this.stateStatus = const StateLoaded(successMessage: 'This is meess')});

  MaintenanceState copyWith({
    final MaintenanceModel? maintenanceModel,
    final StateStatus? stateStatus,
  }) {
    return MaintenanceState(
      maintenanceModel: maintenanceModel ?? this.maintenanceModel,
      stateStatus: stateStatus ?? this.stateStatus,
    );
  }

  @override
  String toString() {
    return "maintenanceModel:$maintenanceModel, stateStatus:$stateStatus}";
  }
}
