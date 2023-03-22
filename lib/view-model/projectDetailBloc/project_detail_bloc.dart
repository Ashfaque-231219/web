import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/auth_repo.dart';
import 'package:web/Repository/project_repository.dart';
import 'package:web/Repository/share_repository.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/generate_report_task_model/generate_report_task_model.dart';
import 'package:web/models/response/get_report_type.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/models/response/project_info_modal.dart';
import 'package:web/models/response/project_list_modal.dart';
import 'package:web/models/response/project_status_modal.dart';
import 'package:web/models/share_model/share_report_modal.dart';
import 'package:web/models/share_model/share_users_list.dart';
import 'package:web/services/request_body.dart';
import 'package:web/view/shared_widget/custom_progress_indicator.dart';

part 'project_detail_event.dart';

part 'project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  AuthRepo authRepo;
  ProjectRepository projectRepository;
  ShareRepository shareRepository;
  Dio? dio;

  ProjectDetailBloc({
    required this.authRepo,
    required this.projectRepository,
    required this.shareRepository,
    this.dio,
  }) : super(ProjectDetailInitial()) {
    on<GetReportTypeEvent>((event, emit) async {
      await _getReportTypeEvent(event, emit);
    });
    on<GetProjectListEvent>((event, emit) async {
      await _getProjectListEvent(event, emit);
    });
    on<GetProjectDetailsEvent>((event, emit) async {
      await _getProjectDetailsEvent(event, emit);
    });
    on<GetProjectInfoEvent>((event, emit) async {
      await _getProjectInfoEvent(event, emit);
    });
    on<GetProjectStatusEvent>((event, emit) async {
      await _getProjectStatusEvent(event, emit);
    });
    on<GenerateTaskReportEvent>((event, emit) async {
      await _generateTaskReportEvent(event, emit);
    });
    on<GetReportUsersEvent>((event, emit) async {
      await _getReportUsersEvent(event, emit);
    });
    on<ShareEvent>((event, emit) async {
      await _shareEvent(event, emit);
    });
  }

  _getReportTypeEvent(GetReportTypeEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      ReportTypeModel? reportType = await authRepo.reportType(event.context);
      if (reportType!.success!) {
        final List<ReportType>? reportTypeList = reportType.data?.reportType;
        emit(const GetReportTypeState().copyWith(reportName: reportTypeList));
      } else {
        debugPrint("error");
      }
    } catch (e) {
      checkStatus(event.context);
      debugPrint(e.toString());
    }
  }

  _getProjectListEvent(GetProjectListEvent event, Emitter<ProjectDetailState> emit) async {
    emit(Loading());
    late BuildContext dialogContext; // global declaration
    if (event.search == null || (event.search != null && event.search!.isEmpty)) {
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
      Map req = RequestBody.projectList(search: event.search);
      ProjectsListModel? projectListModal = await projectRepository.getProjectList(req, event.context);
      if (projectListModal != null && projectListModal.success != null) {
        final ProjectsListModel projectList = projectListModal;
        emit(GetProjectListState(projectList: projectList));
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
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

  _getProjectDetailsEvent(GetProjectDetailsEvent event, Emitter<ProjectDetailState> emit) async {
    BuildContext? dialogContext;
    if (event.loading) {
      emit(Loading());
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
      Map proReq = RequestBody.getProjectStatus(projectId: int.parse(event.projectId ?? "0"));
      ProjectStatusModal projectStatusModal = await projectRepository.getProjectStatus(proReq, event.context);
      if (projectStatusModal.success != null) {
        if (projectStatusModal.data?.status.toString() == "active") {
          Map req = RequestBody.projectDetails(
              projectId: event.projectId,
              search: event.search,
              maintenanceSearch: event.maintenanceSearch,
              punchSearch: event.punchSearch);
          ProjectDetailsModal? projectDetailsModal = await projectRepository.getProjectDetailsList(req, event.context);
          if (projectDetailsModal != null && projectDetailsModal.success != null) {
            final ProjectDetailsModal projectDetails = projectDetailsModal;
            emit(GetProjectDetailsState(projectDetails: projectDetails));
            if (event.loading) {
              Navigator.pop(dialogContext!);
            }
          } else {
            Future.delayed(Duration.zero, () {
              if (event.loading && dialogContext != null) {
                checkStatus(event.context);
                Navigator.pop(dialogContext!);
              }
            });
          }
        } else {
          event.context.router.navigateBack();
          Future.delayed(Duration.zero, () {
            if (dialogContext != null) {
              Navigator.pop(dialogContext!);
            }
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          if (event.loading && dialogContext != null) {
            Navigator.pop(dialogContext!);
            checkStatus(event.context);
          }
        });
        debugPrint("error");
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        if (event.loading && dialogContext != null) {
          Navigator.pop(dialogContext!);
          checkStatus(event.context);
        }
      });
      debugPrint(e.toString());
    }
  }

  _getProjectInfoEvent(GetProjectInfoEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      Map proReq = RequestBody.getProjectStatus(projectId: int.parse(event.projectId ?? "0"));
      ProjectStatusModal projectStatusModal = await projectRepository.getProjectStatus(proReq, event.context);
      if (projectStatusModal.success != null) {
        if (projectStatusModal.data?.status.toString() == "active") {
          Map req = RequestBody.projectInfo(projectId: event.projectId);
          ProjectInfoModal? projectDetailsModal = await projectRepository.getProjectInfo(req, event.context);
          if (projectDetailsModal != null && projectDetailsModal.success != null) {
            final ProjectInfoModal projectDetails = projectDetailsModal;
            emit(GetProjectInfoState(projectDetails: projectDetails));
          } else {
            debugPrint("error");
          }
        } else {
          event.context.router.navigateBack();
        }
      } else {
        debugPrint("error");
      }
    } catch (e) {
      checkStatus(event.context);
      debugPrint(e.toString());
    }
  }

  _getProjectStatusEvent(GetProjectStatusEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      Map req = RequestBody.getProjectStatus(projectId: event.projectId);
      ProjectStatusModal? projectDetailsModal = await projectRepository.getProjectInfo(req, event.context);
      if (projectDetailsModal != null && projectDetailsModal.success != null) {
        final ProjectStatusModal projectDetails = projectDetailsModal;
        emit(GetProjectStatusState(projectDetails: projectDetails));
      } else {
        debugPrint("error");
      }
    } catch (e) {
      checkStatus(event.context);
      debugPrint(e.toString());
    }
  }

  _generateTaskReportEvent(GenerateTaskReportEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      Map req = RequestBody.generateTaskReport(projectId: event.projectId);
      GenerateTaskReportModel generateTaskReportModel = await projectRepository.generateTaskReport(req, event.context!);
      if (generateTaskReportModel.success!) {
        final GenerateTaskReportModel generateTaskReportModels = generateTaskReportModel;
        emit(GenerateReportState(generateModal: generateTaskReportModels));
        Navigator.pop(event.context!);
        showSnackBar(event.context!, generateTaskReportModel.message!);
      } else {
        debugPrint("error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getReportUsersEvent(GetReportUsersEvent event, Emitter<ProjectDetailState> emit) async {
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

  _shareEvent(ShareEvent event, Emitter<ProjectDetailState> emit) async {
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
