import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/punch_list_repository.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/punch_list_modal.dart';

class PunchListServices implements PunchListRepository {
  final Dio dio;

  PunchListServices({required this.dio});

  @override
  Future addPunchListService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.addPunchList, data: req);
      PunchListModal report = PunchListModal.fromJson(response.data);
      return report;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future resolvePunchListService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.editPunchList, data: req);
      PunchListModal report = PunchListModal.fromJson(response.data);
      debugPrint(report.toString());
      return report;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future viewPunchListService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.getPunchList, data: req);
      PunchListModal report = PunchListModal.fromJson(response.data);
      debugPrint(report.toString());
      return report;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }
}
