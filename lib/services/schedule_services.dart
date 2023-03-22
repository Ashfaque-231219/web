import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/schedule_repo.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/schedule_model/EditScheduleModel.dart';
import 'package:web/models/schedule_model/ViewScheduleModelData.dart';
import 'package:web/models/schedule_model/schedule_model.dart';

class ScheduleService implements ScheduleRepository {
  final Dio dio;

  ScheduleService({required this.dio});

  @override
  Future addSchedule(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.addScheduleReports,
        data: req,
      );
      ScheduleModel scheduleModel = ScheduleModel.fromJson(response.data);
      return scheduleModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future viewSchedule(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.viewScheduleReports,
        data: req,
      );
      ViewScheduleModel viewScheduleModel = ViewScheduleModel.fromJson(response.data);
      return viewScheduleModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future editSchedule(Map req, BuildContext context)async {
    try {
      Response response = await dio.post(
        ApiConstants.editScheduleReports,
        data: req,
      );
      EditScheduleModel editScheduleModel = EditScheduleModel.fromJson(response.data);
      return editScheduleModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future deleteSchedule(Map req, BuildContext context)async {
    try {
      Response response = await dio.post(
        ApiConstants.deleteScheduleReports,
        data: req,
      );
      EditScheduleModel editScheduleModel = EditScheduleModel.fromJson(response.data);
      return editScheduleModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
