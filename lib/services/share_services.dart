import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/share_repository.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/share_model/share_report_modal.dart';
import 'package:web/models/share_model/share_users_list.dart';

class ShareServices extends ShareRepository {
  final Dio dio;

  ShareServices({required this.dio});

  @override
  Future shareReportUsers(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.shareReportUsers,
        data: req,
      );
      GetShareUsersList shareModel = GetShareUsersList.fromJson(response.data);
      return shareModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }

  @override
  Future shareReportsMail(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiConstants.shareReport,
        data: req,
      );
      ShareReportModal shareModel = ShareReportModal.fromJson(response.data);
      return shareModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
