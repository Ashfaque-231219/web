import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/punch_list_repository.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/punch_list_modal.dart';
import 'package:web/services/request_body.dart';
import 'package:web/view/shared_widget/custom_progress_indicator.dart';

part 'punch_list_event.dart';

part 'punch_list_state.dart';

class PunchListBloc extends Bloc<PunchListEvent, PunchListState> {
  PunchListRepository punchListRepository;
  Dio? dio;

  PunchListBloc({required this.punchListRepository, this.dio}) : super(PunchListInitial()) {
    on<AddReportEvent>((event, emit) async {
      await _addReportEvent(event, emit);
    });
    on<EditReportEvent>((event, emit) async {
      await _editReportEvent(event, emit);
    });
    on<ViewReportEvent>((event, emit) async {
      await _viewReportEvent(event, emit);
    });
  }

  _addReportEvent(AddReportEvent event, Emitter<PunchListState> emit) async {
    emit(Loading());
    late BuildContext dialogContext; // global declaration
    Future.delayed(Duration.zero, () {
      return showDialog(
          context: event.context,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });

    try {
      Map req = RequestBody.addPunchList(
        punchListId: event.punchListId,
        projectId: event.projectId,
        image: event.image,
        description: event.description,
        date: event.date,
      );

      debugPrint("req");
      debugPrint(req.toString());

      PunchListModal? punchList = await punchListRepository.addPunchListService(req, event.context);
      if (punchList!.success!) {
        emit(AddPunchListState(report: punchList));
        Future.delayed(Duration.zero, () {
          Navigator.pop(event.context);
          Navigator.pop(dialogContext);
          showSnackBar(event.context, punchList.message!);
          // event.context.router.navigateBack();
        });
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          checkStatus(event.context);
        });
        debugPrint("error");
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        Navigator.pop(dialogContext);
        checkStatus(event.context);
      });
      debugPrint(e.toString());
    }
  }

  _editReportEvent(EditReportEvent event, Emitter<PunchListState> emit) async {
    emit(Loading());
    late BuildContext dialogContext; // global declaration
    Future.delayed(Duration.zero, () {
      return showDialog(
          context: event.context,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });

    try {
      Map req = RequestBody.editPunchList(
        punchListId: event.id,
        image: event.image,
        description: event.description,
      );

      debugPrint("req");
      debugPrint(req.toString());

      PunchListModal? punchList = await punchListRepository.resolvePunchListService(
        req,
        event.context,
      );
      if (punchList!.success!) {
        emit(EditPunchListState(report: punchList));
        Future.delayed(Duration.zero, () {
          Navigator.pop(event.context);
          Navigator.pop(dialogContext);
          showSnackBar(event.context, punchList.message!);
          // event.context.router.navigateBack();
        });
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          checkStatus(event.context);
        });
        debugPrint("error");
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        Navigator.pop(dialogContext);
        checkStatus(event.context);
      });
      debugPrint(e.toString());
    }
  }

  _viewReportEvent(ViewReportEvent event, Emitter<PunchListState> emit) async {
    emit(Loading());
    late BuildContext dialogContext; // global declaration
    Future.delayed(Duration.zero, () {
      return showDialog(
          context: event.context,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });

    try {
      Map req = RequestBody.viewPunchList(
        punchListId: event.id,
      );

      debugPrint("req");
      debugPrint(req.toString());

      PunchListModal? punchList = await punchListRepository.viewPunchListService(req, event.context);
      if (punchList!.success!) {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
        });
        emit(ViewPunchListState(report: punchList));
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          checkStatus(event.context);
        });
        debugPrint("error");
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        Navigator.pop(dialogContext);
        checkStatus(event.context);
      });
      debugPrint(e.toString());
    }
  }
}
