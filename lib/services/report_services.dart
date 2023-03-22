import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/report_repository.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/report_list_modal.dart';
import 'package:web/models/response/site_survey_report_modal.dart';

class ReportServices implements ReportRepository {
  final Dio dio;

  ReportServices({required this.dio});

  @override
  Future getReportListService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.reportsList, data: req);
      ReportListModal reportList = ReportListModal.fromJson(response.data);
      return reportList;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future addSiteSurveyReportService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.addSiteSurveyReport, data: req);
      SiteSurveyModal report = SiteSurveyModal.fromJson(response.data);
      return report;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future editSiteSurveyReportService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.editSiteSurveyReport, data: req);
      SiteSurveyModal report = SiteSurveyModal.fromJson(response.data);
      debugPrint(report.toString());
      return report;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future viewSiteSurveyReportService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.viewSiteSurveyReport, data: req);
      SiteSurveyModal report = SiteSurveyModal.fromJson(response.data);
      debugPrint(report.toString());
      return report;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
