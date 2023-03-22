import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/maintenance_repository.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/maintenance_model/maintenance_model.dart';

class MaintenanceService implements MaintenanceRepository {
  final Dio dio;

  MaintenanceService({required this.dio});

  @override
  Future addMaintenance(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.addMaintenance,
        data: req,
      );
      print("The response is =====>>>>>>> $response");
      MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(response.data);
      return maintenanceModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future resolveMaintenance(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.editMaintenance,
        data: req,
      );
      print("The response is =====>>>>>>> $response");
      MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(response.data);
      return maintenanceModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future viewMaintenance(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.viewMaintenance,
        data: req,
      );
      print("The response is =====>>>>>>> $response");

      MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(response.data);
      print("The response is =====>>>>>>> ${maintenanceModel.data?.id}");
      return maintenanceModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
