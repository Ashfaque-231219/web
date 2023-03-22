import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/maintenance_repository.dart';
import 'package:web/models/maintenance_model/maintenance_model.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view/shared_widget/custom_progress_indicator.dart';

import '../../helper/utils/utils.dart';
import '../../services/request_body.dart';

part 'maintenance_event.dart';

part 'maintenance_state.dart';

class MaintenanceBloc extends Bloc<MaintenanceEvent, MaintenanceState> {
  MaintenanceRepository maintenanceRepository;
  Dio? dio;

  MaintenanceBloc({required this.maintenanceRepository, this.dio}) : super(MaintenanceState()) {
    on<AddMaintenanceEvent>((event, emit) async {
      await _addMaintenanceEvent(event, emit);
    });
    on<ResolveMaintenanceEvent>((event, emit) async {
      await _resolveMaintenanceEvent(event, emit);
    });
    on<ViewMaintenanceEvent>((event, emit) async {
      await _viewMaintenanceEvent(event, emit);
    });
  }

  _addMaintenanceEvent(AddMaintenanceEvent event, Emitter<MaintenanceState> emit) async {
    emit(state.copyWith(stateStatus: StateLoading()));
    late BuildContext dialogContext; // global declaration
    Future.delayed(Duration.zero, () {
      return showDialog(
          context: event.context!,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });
    try {
      Map req = RequestBody.addMaintenance(
        projectId: event.projectId,
        maintenanceId: event.maintenanceId,
        beforeImage: event.beforeImage,
        beforeDescription: event.beforeDescription,
        videoType: event.videoType,
      );
      MaintenanceModel maintenanceModel = await maintenanceRepository.addMaintenance(req, event.context!);
      if (maintenanceModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: maintenanceModel.message.toString())));
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
        });
        event.context!.router.navigateBack();
        showSnackBar(event.context!, maintenanceModel.message!);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: maintenanceModel.message.toString())));
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          checkStatus(event.context!);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      Future.delayed(Duration.zero, () {
        Navigator.pop(dialogContext);
        checkStatus(event.context!);
      });
    }
  }

  _resolveMaintenanceEvent(ResolveMaintenanceEvent event, Emitter<MaintenanceState> emit) async {
    emit(state.copyWith(stateStatus: StateLoading()));
    late BuildContext dialogContext; // global declaration
    Future.delayed(Duration.zero, () {
      return showDialog(
          context: event.context!,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });
    try {
      Map req = RequestBody.resolveMaintenance(
        id: event.maintenanceId,
        afterImage: event.afterImage,
        afterDescription: event.afterDescription,
        videoType: event.videoType,
      );
      MaintenanceModel maintenanceModel = await maintenanceRepository.resolveMaintenance(req, event.context!);
      if (maintenanceModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: maintenanceModel.message.toString())));
        event.context!.router.navigateBack();
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
        });
        // Navigator.pop(event.context!);
        showSnackBar(event.context!, maintenanceModel.message!);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: maintenanceModel.message.toString())));
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          checkStatus(event.context!);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      Future.delayed(Duration.zero, () {
        Navigator.pop(dialogContext);
        checkStatus(event.context!);
      });
    }
  }

  _viewMaintenanceEvent(ViewMaintenanceEvent event, Emitter<MaintenanceState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.viewMaintenance(
        id: event.maintenanceId,
      );
      MaintenanceModel maintenanceModel = await maintenanceRepository.viewMaintenance(req, event.context!);
      if (maintenanceModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: maintenanceModel.message.toString()), maintenanceModel: maintenanceModel));
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: maintenanceModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      checkStatus(event.context!);
      debugPrint(e.toString());
    }
  }
}
