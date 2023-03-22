import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/report_repository.dart';
import 'package:web/Repository/share_repository.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/main.dart';
import 'package:web/models/response/report_list_modal.dart';
import 'package:web/models/response/site_survey_report_modal.dart';
import 'package:web/models/share_model/share_report_modal.dart';
import 'package:web/models/share_model/share_users_list.dart';
import 'package:web/services/request_body.dart';
import 'package:web/view/shared_widget/custom_progress_indicator.dart';

part 'site_survey_report_event.dart';

part 'site_survey_report_state.dart';

class SiteSurveyReportBloc extends Bloc<SiteSurveyReportEvent, SiteSurveyReportState> {
  ReportRepository reportRepository;
  ShareRepository shareRepository;
  Dio? dio;

  SiteSurveyReportBloc({required this.reportRepository, required this.shareRepository, this.dio})
      : super(SiteSurveyReportInitial()) {
    on<GetReportListEvent>((event, emit) async {
      await _getReportListEvent(event, emit);
    });
    on<AddReportEvent>((event, emit) async {
      await _addReportEvent(event, emit);
    });
    on<EditReportEvent>((event, emit) async {
      await _editReportEvent(event, emit);
    });
    on<ViewReportEvent>((event, emit) async {
      await _viewReportEvent(event, emit);
    });
    on<GetReportUsersEvent>((event, emit) async {
      await _getReportUsersEvent(event, emit);
    });
    on<ShareEvent>((event, emit) async {
      await _shareEvent(event, emit);
    });
  }

  _getReportListEvent(GetReportListEvent event, Emitter<SiteSurveyReportState> emit) async {
    emit(Loading());
    BuildContext? dialogContext; // global declaration
    if (event.search == null ||
        (event.search != null && event.search!.isEmpty) ||
        (event.loading != null && event.loading!)) {
      Future.delayed(Duration.zero, () {
        return showDialog(
            context: event.context,
            builder: (context) {
              dialogContext = context;
              return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
            });
      });
    }
    try {
      Map req = RequestBody.reportList(search: event.search);
      ReportListModal? reportListModal = await reportRepository.getReportListService(req, event.context);
      if (reportListModal != null && reportListModal.success != null) {
        final ReportListModal reportsList = reportListModal;
        emit(GetReportsListState(reportList: reportsList));
        Future.delayed(Duration.zero, () {
          if (event.search == null ||
              (event.search != null && event.search!.isEmpty) ||
              (event.loading != null && event.loading!)) {
            if (dialogContext != null) {
              Navigator.pop(dialogContext!);
            }
          }
        });
      } else {
        Future.delayed(Duration.zero, () {
          if (event.search == null ||
              (event.search != null && event.search!.isEmpty) ||
              (event.loading != null && event.loading!)) {
            if (dialogContext != null) {
              Navigator.pop(dialogContext!);
            }
          }
          checkStatus(event.context);
        });
        debugPrint("error");
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        if (event.search == null ||
            (event.search != null && event.search!.isEmpty) ||
            (event.loading != null && event.loading!)) {
          if (dialogContext != null) {
            Navigator.pop(dialogContext!);
          }
        }
        checkStatus(event.context);
      });
      debugPrint(e.toString());
    }
  }

  _addReportEvent(AddReportEvent event, Emitter<SiteSurveyReportState> emit) async {
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
      Map req = RequestBody.addSiteSurveyReport(
        projectId: event.projectId,
        length: event.length,
        width: event.width,
        area: event.area,
        onLoadingLocation: event.onLoadingLocation,
        offLoadingLocation: event.offLoadingLocation,
        reportCategoryId: event.reportCategoryId,
        description: event.description,
        layoutPlanImage: event.layoutPlanImage,
        image360Degree: event.image360Degree,
        videoType: event.videoType,
      );

      debugPrint("req");
      debugPrint(req.toString());

      SiteSurveyModal? reportType = await reportRepository.addSiteSurveyReportService(req, event.context);
      if (reportType!.success!) {
        emit(AddSiteSurveyReportState(reportName: reportType));
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          showSnackBar(event.context, reportType.message!);
          event.context.router.navigateBack();
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

  _editReportEvent(EditReportEvent event, Emitter<SiteSurveyReportState> emit) async {
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
      Map req = RequestBody.editSiteSurveyReport(
        id: event.reportId,
        projectId: event.projectId,
        length: event.length,
        width: event.width,
        area: event.area,
        onLoadingLocation: event.onLoadingLocation,
        offLoadingLocation: event.offLoadingLocation,
        reportCategoryId: event.reportCategoryId,
        description: event.description,
        layoutPlanImage: event.layoutPlanImage,
        image360Degree: event.image360Degree,
        videoType: event.videoType,
      );

      debugPrint("req");
      debugPrint(req.toString());

      SiteSurveyModal? report = await reportRepository.editSiteSurveyReportService(req, event.context);
      if (report!.success!) {
        emit(EditSiteSurveyReportState(report: report));
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          showSnackBar(event.context, report.message!);
          event.context.router.navigateBack();
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

  _viewReportEvent(ViewReportEvent event, Emitter<SiteSurveyReportState> emit) async {
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
      Map req = RequestBody.viewSiteSurveyReport(reportId: event.reportId);
      SiteSurveyModal? reportModal = await reportRepository.viewSiteSurveyReportService(req, event.context);
      if (reportModal != null && reportModal.success != null) {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
        });
        emit(ViewSiteSurveyReportState(report: reportModal));
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          checkStatus(event.context);
        });
        debugPrint("error");
      }
    } catch (e) {
      checkStatus(event.context);
      debugPrint(e.toString());
    }
  }

  _getReportUsersEvent(GetReportUsersEvent event, Emitter<SiteSurveyReportState> emit) async {
    emit(Loading());
    BuildContext? dialogContext; // global declaration
    Future.delayed(Duration.zero, () {
      showDialog(
          context: event.context,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });
    try {
      Map req = RequestBody.getReportUsers(
        reportId: event.reportId,
        reportType: event.reportType,
      );
      GetShareUsersList shareUsers = await shareRepository.shareReportUsers(req, event.context);
      if (shareUsers.success!) {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext!);
        });
        emit(GetReportUsersState(shareModal: shareUsers));
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext!);
          checkStatus(event.context);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      Future.delayed(Duration.zero, () {
        Navigator.pop(dialogContext!);
        checkStatus(event.context);
      });
    }
  }

  _shareEvent(ShareEvent event, Emitter<SiteSurveyReportState> emit) async {
    emit(Loading());
    BuildContext? dialogContext;
    Future.delayed(Duration.zero, () {
      showDialog(
          context: event.context,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });
    try {
      Map req = RequestBody.shareReport(
        reportId: event.reportId,
        mailId: event.mailId,
        reportType: event.reportType,
      );
      ShareReportModal share = await shareRepository.shareReportsMail(req, event.context);
      if (share.success!) {
        Future.delayed(Duration.zero, () {
          if (dialogContext != null) {
            Navigator.pop(dialogContext!);
          }else{
            navigatorKey.currentState?.pop();
          }
          showSnackBar(event.context, share.message!);
        });
      } else {
        Future.delayed(Duration.zero, () {
          if (dialogContext != null) {
            Navigator.pop(dialogContext!);
          }
          checkStatus(event.context);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      Future.delayed(Duration.zero, () {
        if (dialogContext != null) {
          Navigator.pop(dialogContext!);
        }
        checkStatus(event.context);
      });
    }
  }
}
