import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/notification_repository.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/notification/notification_model.dart';

class NotificationService implements NotificationRepository {
  final Dio dio;

  NotificationService({required this.dio});

  @override
  Future notifications(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.notificationsList, data: req);
      NotificationModel notificationsModel = NotificationModel.fromJson(response.data);
      return notificationsModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
