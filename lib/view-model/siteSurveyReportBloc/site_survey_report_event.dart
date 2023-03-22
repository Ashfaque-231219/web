part of 'site_survey_report_bloc.dart';

abstract class SiteSurveyReportEvent extends Equatable {
  const SiteSurveyReportEvent();

  @override
  List<Object?> get props => [];
}

class GetReportListEvent extends SiteSurveyReportEvent {
  final BuildContext context;
  final String? search;
  final bool? loading;

  const GetReportListEvent({required this.context, this.search, this.loading = true});
}

class AddReportEvent extends SiteSurveyReportEvent {
  final String? projectId;
  final String? length;
  final String? width;
  final String? area;
  final String? onLoadingLocation;
  final String? offLoadingLocation;
  final int? reportCategoryId;
  final String? description;
  final String? layoutPlanImage;
  final String? image360Degree;
  final bool? videoType;
  final BuildContext context;

  const AddReportEvent(
      {required this.projectId,
      required this.length,
      required this.width,
      required this.area,
      required this.onLoadingLocation,
      required this.offLoadingLocation,
      required this.reportCategoryId,
      required this.description,
      required this.layoutPlanImage,
      required this.image360Degree,
      required this.videoType,
      required this.context});
}

class ViewReportEvent extends SiteSurveyReportEvent {
  final BuildContext context;
  final int? reportId;

  const ViewReportEvent({required this.context, this.reportId});
}

class EditReportEvent extends SiteSurveyReportEvent {
  final int? reportId;
  final String? projectId;
  final String? length;
  final String? width;
  final String? area;
  final String? onLoadingLocation;
  final String? offLoadingLocation;
  final int? reportCategoryId;
  final String? description;
  final String? layoutPlanImage;
  final String? image360Degree;
  final bool? videoType;
  final BuildContext context;

  const EditReportEvent(
      {required this.reportId,
      required this.projectId,
      required this.length,
      required this.width,
      required this.area,
      required this.onLoadingLocation,
      required this.offLoadingLocation,
      required this.reportCategoryId,
      required this.description,
      required this.layoutPlanImage,
      required this.image360Degree,
      required this.videoType,
      required this.context});
}

class GetReportUsersEvent extends SiteSurveyReportEvent {
  final BuildContext context;
  final List<String>? reportId;
  final String? reportType;

  const GetReportUsersEvent({
    required this.context,
    required this.reportId,
    required this.reportType,
  });
}

class ShareEvent extends SiteSurveyReportEvent {
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
