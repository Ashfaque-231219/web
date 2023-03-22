import 'package:flutter/material.dart';

abstract class ReportRepository{
  Future getReportListService(Map req, BuildContext context);
  Future addSiteSurveyReportService(Map req, BuildContext context);
  Future viewSiteSurveyReportService(Map req, BuildContext context);
  Future editSiteSurveyReportService(Map req, BuildContext context);
}