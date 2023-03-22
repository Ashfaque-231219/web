import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/schedule_repo.dart';
import 'package:web/models/schedule_model/ViewScheduleModelData.dart';
import 'package:web/models/schedule_model/schedule_model.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view-model/schedule_bloc/schedule_event.dart';

import '../../helper/utils/utils.dart';
import '../../models/schedule_model/EditScheduleModel.dart';
import '../../services/request_body.dart';

part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleRepository scheduleRepository;
  Dio? dio;

  ScheduleBloc({required this.scheduleRepository, this.dio}) : super(ScheduleState()) {
    on<AddScheduleEvent>((event, emit) async {
      await _addScheduleEvent(event, emit);
    });
    on<ViewScheduleEvent>((event, emit) async {
      await _viewScheduleEvent(event, emit);
    });
    on<EditScheduleReportEvent>((event, emit) async {
      await _editScheduleReportEvent(event, emit);
    });
    on<DeleteScheduleReportEvent>((event, emit) async {
      await _deleteScheduleReportEvent(event, emit);
    });
  }

  _addScheduleEvent(AddScheduleEvent event, Emitter<ScheduleState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.addSchedule(projectId: event.projectId, description: event.description, date: event.date);
      ScheduleModel scheduleModel = await scheduleRepository.addSchedule(req, event.context!);
      if (scheduleModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: scheduleModel.message.toString())));
        // event.context!.router.navigateBack();
        showSnackBar(event.context!, scheduleModel.message!);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: scheduleModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(event.context!);
    }
  }

  _viewScheduleEvent(ViewScheduleEvent event, Emitter<ScheduleState> emit) async {
    try {
      emit(state.copyWith(viewStateStatus: StateLoading()));
      Map req = RequestBody.viewSchedule(projectId: '1');
      ViewScheduleModel viewScheduleModel = await scheduleRepository.viewSchedule(req, event.context!);
      if (viewScheduleModel.success!) {
        emit(
            state.copyWith(viewScheduleModel: viewScheduleModel, viewStateStatus: StateLoaded(successMessage: viewScheduleModel.message.toString())));
        // event.context!.router.navigateBack();
      } else {
        emit(state.copyWith(viewStateStatus: StateFailed(errorMessage: viewScheduleModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      checkStatus(event.context!);
      debugPrint(e.toString());
    }
  }

  _editScheduleReportEvent(EditScheduleReportEvent event, Emitter<ScheduleState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.editSchedule(scheduleId: event.id, description: event.description, date: event.date);
      EditScheduleModel editScheduleModel = await scheduleRepository.editSchedule(req, event.context!);
      if (editScheduleModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: editScheduleModel.message.toString())));
        // event.context!.router.navigateBack();
        showSnackBar(event.context!, editScheduleModel.message!);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: editScheduleModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(event.context!);
    }
  }

  _deleteScheduleReportEvent(DeleteScheduleReportEvent event, Emitter<ScheduleState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.deleteSchedule(scheduleId: event.id);
      EditScheduleModel editScheduleModel = await scheduleRepository.deleteSchedule(req, event.context!);
      if (editScheduleModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: editScheduleModel.message.toString())));
        showSnackBar(event.context!, editScheduleModel.message!);
        // if (event.projectId != null && event.projectId!.isNotEmpty) {
        //   event.context!.router.popAndPush(ProjectDetails(id: int.parse(event.projectId!)));
        // } else {
        //   event.context!.router.navigateBack();
        // }
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: editScheduleModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(event.context!);
    }
  }
}
