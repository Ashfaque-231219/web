part of 'project_detail_bloc.dart';

abstract class ProjectDetailState extends Equatable {
  const ProjectDetailState();

  @override
  List<Object?> get props => [];
}

class ProjectDetailInitial extends ProjectDetailState {}

class Loading extends ProjectDetailState {}

class GetReportTypeState extends ProjectDetailState {
  final List<ReportType>? reportName;

  const GetReportTypeState({this.reportName});

  GetReportTypeState copyWith({
    final List<ReportType>? reportName,
  }) {
    return GetReportTypeState(reportName: reportName ?? this.reportName);
  }

  @override
  String toString() {
    return "GetReportTypeState{reportName:$reportName}";
  }
}

class GetProjectListState extends ProjectDetailState {
  final ProjectsListModel? projectList;

  const GetProjectListState({this.projectList});

  GetProjectListState copyWith({
    final ProjectsListModel? projectList,
  }) {
    return GetProjectListState(projectList: projectList ?? this.projectList);
  }

  @override
  String toString() {
    return "ProjectsListState{projectList:$projectList}";
  }

  @override
  List<Object?> get props => [projectList];
}

class GetProjectDetailsState extends ProjectDetailState {
  final ProjectDetailsModal? projectDetails;

  const GetProjectDetailsState({this.projectDetails});

  GetProjectDetailsState copyWith({
    final ProjectDetailsModal? projectDetails,
  }) {
    return GetProjectDetailsState(projectDetails: projectDetails ?? this.projectDetails);
  }

  @override
  String toString() {
    return "ProjectsDetailsState{projectList:$projectDetails}";
  }

  @override
  List<Object?> get props => [projectDetails];
}

class GetProjectInfoState extends ProjectDetailState {
  final ProjectInfoModal? projectDetails;

  const GetProjectInfoState({this.projectDetails});

  GetProjectInfoState copyWith({
    final ProjectInfoModal? projectDetails,
  }) {
    return GetProjectInfoState(projectDetails: projectDetails ?? this.projectDetails);
  }

  @override
  String toString() {
    return "ProjectsInfoState{projectList:$projectDetails}";
  }

  @override
  List<Object?> get props => [projectDetails];
}

class GetProjectStatusState extends ProjectDetailState {
  final ProjectStatusModal? projectDetails;

  const GetProjectStatusState({this.projectDetails});

  GetProjectStatusState copyWith({
    final ProjectStatusModal? projectDetails,
  }) {
    return GetProjectStatusState(projectDetails: projectDetails ?? this.projectDetails);
  }

  @override
  String toString() {
    return "GetProjectStatusState{projectList:$projectDetails}";
  }

  @override
  List<Object?> get props => [projectDetails];
}

class GetReportUsersState extends ProjectDetailState {
  final GetShareUsersList? shareModal;

  const GetReportUsersState({this.shareModal});

  GetReportUsersState copyWith({final GetShareUsersList? shareModal}) {
    return GetReportUsersState(shareModal: shareModal ?? this.shareModal);
  }

  @override
  String toString() {
    return "GetReportUsersState{shareModal:$shareModal}";
  }

  @override
  List<Object?> get props => [shareModal];
}

class ShareState extends ProjectDetailState {
  final ShareReportModal? shareModal;

  const ShareState({this.shareModal});

  ShareState copyWith({final ShareReportModal? shareModal}) {
    return ShareState(shareModal: shareModal ?? this.shareModal);
  }

  @override
  String toString() {
    return "ShareState{shareModal:$shareModal}";
  }

  @override
  List<Object?> get props => [shareModal];
}

class GenerateReportState extends ProjectDetailState {
  final GenerateTaskReportModel? generateModal;

  const GenerateReportState({this.generateModal});

  GenerateReportState copyWith({final GenerateTaskReportModel? generateModal}) {
    return GenerateReportState(generateModal: generateModal ?? this.generateModal);
  }

  @override
  String toString() {
    return "GenerateReportState{generateModal:$generateModal}";
  }

  @override
  List<Object?> get props => [generateModal];
}
