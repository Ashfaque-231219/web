import 'package:web/models/task_model/view_task_report_model.dart';
import 'package:web/view-model/event_status.dart';

class TaskReportState {
  final StateStatus stateStatus;
  final StateStatus viewStateStatus;
  final ViewInspectionReportModel? viewInspectionReport;

  TaskReportState({this.stateStatus = const StateNotLoaded(), this.viewStateStatus = const StateNotLoaded(), this.viewInspectionReport});

  TaskReportState copyWith({
    final StateStatus? stateStatus,
    final StateStatus? viewStateStatus,
    final ViewInspectionReportModel? viewInspectionReport,
  }) {
    return TaskReportState(
      stateStatus: stateStatus ?? this.stateStatus,
      viewStateStatus: viewStateStatus ?? this.viewStateStatus,
      viewInspectionReport: viewInspectionReport ?? this.viewInspectionReport,
    );
  }

  @override
  String toString() {
    return " stateStatus:$stateStatus, viewStateStatus:$viewStateStatus, viewInspectionReport:$viewInspectionReport";
  }
}