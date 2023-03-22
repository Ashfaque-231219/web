import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/task_repo.dart';
import 'package:web/models/task_model/EditTaskReportModelData.dart';
import 'package:web/models/task_model/add_task_model.dart';
import 'package:web/models/task_model/view_task_report_model.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view-model/task_report_bloc/task_report_event.dart';
import 'package:web/view-model/task_report_bloc/task_report_state.dart';

import '../../helper/utils/utils.dart';
import '../../services/request_body.dart';

class TaskBloc extends Bloc<TaskReportEvent, TaskReportState> {
  TaskRepository taskRepository;
  Dio? dio;

  TaskBloc({required this.taskRepository, this.dio}) : super(TaskReportState()) {
    on<AddTaskReportEvent>((event, emit) async {
      await _addTaskReportEvent(event, emit);
    });
    on<EditTaskReportEvent>((event, emit) async {
      await _editTaskReportEvent(event, emit);
    });
    on<DeleteTaskReportEvent>((event, emit) async {
      await _deleteTaskReportEvent(event, emit);
    });
    on<ViewTaskReportEvent>((event, emit) async {
      await _viewTaskReportEvent(event, emit);
    });
  }

  _addTaskReportEvent(AddTaskReportEvent event, Emitter<TaskReportState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.addTaskReport(projectId: event.projectId, description: event.description, date: event.date, image: event.image);
      AddTaskModel addTaskModel = await taskRepository.addTaskReport(req, event.context!);
      if (addTaskModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: addTaskModel.message.toString())));
        // event.context!.router.navigateBack();
        showSnackBar(event.context!, addTaskModel.message!);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: addTaskModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      checkStatus(event.context!);
      print(e.toString());
    }
  }

  _editTaskReportEvent(EditTaskReportEvent event, Emitter<TaskReportState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.editTaskReport(taskId: event.taskId, description: event.description, date: event.date, image: event.image);
      EditTaskReportModel editTaskReportModel = await taskRepository.editTaskReport(req, event.context!);
      if (editTaskReportModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: editTaskReportModel.message.toString())));
        // event.context!.router.navigateBack();
        showSnackBar(event.context!, editTaskReportModel.message!);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: editTaskReportModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      print(e.toString());
      checkStatus(event.context!);
    }
  }

  _deleteTaskReportEvent(DeleteTaskReportEvent event, Emitter<TaskReportState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.deleteTaskReport(
        taskId: event.taskId,
      );
      EditTaskReportModel editTaskReportModel = await taskRepository.deleteTaskReport(req, event.context!);
      if (editTaskReportModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: editTaskReportModel.message.toString())));
        // event.context!.router.navigateBack();
        showSnackBar(event.context!, editTaskReportModel.message!);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: editTaskReportModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      print(e.toString());
      checkStatus(event.context!);
    }
  }

  _viewTaskReportEvent(ViewTaskReportEvent event, Emitter<TaskReportState> emit) async {
    try {
      emit(state.copyWith(viewStateStatus: StateLoading()));
      Map req = RequestBody.viewTaskReport(
        reportId: event.reportId,
      );
      ViewInspectionReportModel viewInspectionReport = await taskRepository.viewTaskReport(req, event.context!);
      if (viewInspectionReport.success!) {
        emit(state.copyWith(
          viewStateStatus: StateLoaded(successMessage: viewInspectionReport.message.toString()),
          viewInspectionReport: viewInspectionReport,
        ));
      } else {
        emit(state.copyWith(viewStateStatus: StateFailed(errorMessage: viewInspectionReport.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      print(e.toString());
      checkStatus(event.context!);
    }
  }
}
