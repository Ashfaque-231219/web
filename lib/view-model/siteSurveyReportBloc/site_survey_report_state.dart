part of 'site_survey_report_bloc.dart';

abstract class SiteSurveyReportState extends Equatable {
  const SiteSurveyReportState();

  @override
  List<Object?> get props => [];
}

class SiteSurveyReportInitial extends SiteSurveyReportState {}

class Loading extends SiteSurveyReportState {}

class GetReportsListState extends SiteSurveyReportState {
  final ReportListModal? reportList;

  const GetReportsListState({this.reportList});

  GetReportsListState copyWith({
    final ReportListModal? reportList,
  }) {
    return GetReportsListState(reportList: reportList ?? this.reportList);
  }

  @override
  String toString() {
    return "ReportsListState{reportList:$reportList}";
  }

  @override
  List<Object?> get props => [reportList];
}

class AddSiteSurveyReportState extends SiteSurveyReportState {
  final SiteSurveyModal? reportName;

  const AddSiteSurveyReportState({this.reportName});

  AddSiteSurveyReportState copyWith({
    final SiteSurveyModal? reportName,
  }) {
    return AddSiteSurveyReportState(reportName: reportName ?? this.reportName);
  }

  @override
  String toString() {
    return "State{reportName:$reportName}";
  }
}

class EditSiteSurveyReportState extends SiteSurveyReportState {
  final SiteSurveyModal? report;

  const EditSiteSurveyReportState({this.report});

  EditSiteSurveyReportState copyWith({
    final SiteSurveyModal? report,
  }) {
    return EditSiteSurveyReportState(report: report ?? this.report);
  }

  @override
  String toString() {
    return "State{reportName:$report}";
  }
}

class ViewSiteSurveyReportState extends SiteSurveyReportState {
  final SiteSurveyModal? report;

  const ViewSiteSurveyReportState({this.report});

  ViewSiteSurveyReportState copyWith({
    final SiteSurveyModal? report,
  }) {
    return ViewSiteSurveyReportState(report: report ?? this.report);
  }

  @override
  String toString() {
    return "State{reportName:${report?.data?.id}}";
  }
}

class GetReportUsersState extends SiteSurveyReportState {
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

class ShareState extends SiteSurveyReportState {
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
