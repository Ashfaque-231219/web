import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/task_repo.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/task_model/EditTaskReportModelData.dart';
import 'package:web/models/task_model/add_task_model.dart';
import 'package:web/models/task_model/view_task_report_model.dart';

class TaskService implements TaskRepository {
  final Dio dio;

  TaskService({required this.dio});

  @override
  Future addTaskReport(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.addTaskReport,
        data: req,
      );
      AddTaskModel addTaskModel = AddTaskModel.fromJson(response.data);
      return addTaskModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future editTaskReport(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.editTaskReport,
        data: req,
      );
      EditTaskReportModel editTaskReportModel = EditTaskReportModel.fromJson(response.data);
      return editTaskReportModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future deleteTaskReport(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.deleteTaskReport,
        data: req,
      );
      EditTaskReportModel editTaskReportModel = EditTaskReportModel.fromJson(response.data);
      return editTaskReportModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future viewTaskReport(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.viewTaskReport, data: req);
      ViewInspectionReportModel editTaskReportModel = ViewInspectionReportModel.fromJson(response.data);
      return editTaskReportModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
