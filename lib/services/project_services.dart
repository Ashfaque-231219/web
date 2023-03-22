import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/project_repository.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/generate_report_task_model/generate_report_task_model.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/models/response/project_info_modal.dart';
import 'package:web/models/response/project_list_modal.dart';
import 'package:web/models/response/project_status_modal.dart';

class ProjectServices implements ProjectRepository {
  final Dio dio;

  ProjectServices({required this.dio});

  @override
  Future getProjectList(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.projectList, data: req);
      ProjectsListModel getProjectDetails = ProjectsListModel.fromJson(response.data);
      return getProjectDetails;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future getProjectDetailsList(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.projectDetails, data: req);
      ProjectDetailsModal getProjectDetails = ProjectDetailsModal.fromJson(response.data);
      return getProjectDetails;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future getProjectInfo(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.projectInfo, data: req);
      ProjectInfoModal getProjectDetails = ProjectInfoModal.fromJson(response.data);
      return getProjectDetails;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future getProjectStatus(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.getProjectStatus, data: req);
      ProjectStatusModal getProjectDetails = ProjectStatusModal.fromJson(response.data);
      return getProjectDetails;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
  @override
  Future generateTaskReport(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.generateReport,
        data: req,
      );
      GenerateTaskReportModel generateTaskReportModel = GenerateTaskReportModel.fromJson(response.data);
      return generateTaskReportModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
