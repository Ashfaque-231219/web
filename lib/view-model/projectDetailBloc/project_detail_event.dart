part of 'project_detail_bloc.dart';

abstract class ProjectDetailEvent extends Equatable {
  const ProjectDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetReportTypeEvent extends ProjectDetailEvent {
  final BuildContext context;

  const GetReportTypeEvent({required this.context});
}

class GetProjectListEvent extends ProjectDetailEvent {
  final BuildContext context;
  final String? search;

  const GetProjectListEvent({required this.context, this.search});
}

class GetProjectDetailsEvent extends ProjectDetailEvent {
  final BuildContext context;
  final String? projectId;
  final String? search;
  final String? maintenanceSearch;
  final String? punchSearch;
  final bool loading;

  const GetProjectDetailsEvent({
    required this.context,
    required this.projectId,
    this.search,
    this.maintenanceSearch,
    this.punchSearch,
    this.loading = true,
  });
}

class GetProjectInfoEvent extends ProjectDetailEvent {
  final BuildContext context;
  final String? projectId;

  const GetProjectInfoEvent({required this.context, required this.projectId});
}

class GetProjectStatusEvent extends ProjectDetailEvent {
  final BuildContext context;
  final int? projectId;

  const GetProjectStatusEvent({required this.context, required this.projectId});
}

class GenerateTaskReportEvent extends ProjectDetailEvent {
  final BuildContext? context;
  final String? projectId;

  const GenerateTaskReportEvent({
    this.context,
    this.projectId = '',
  });
}

class GetReportUsersEvent extends ProjectDetailEvent {
  final BuildContext context;
  final List<String>? reportId;
  final String? reportType;

  const GetReportUsersEvent({
    required this.context,
    required this.reportId,
    required this.reportType,
  });
}

class ShareEvent extends ProjectDetailEvent {
  final BuildContext context;
  final List<String>? reportId;
  final List<String>? mailId;
  final String? reportType;

  const ShareEvent({
    required this.context,
    required this.reportId,
    required this.mailId,
    required this.reportType,
  });
}
