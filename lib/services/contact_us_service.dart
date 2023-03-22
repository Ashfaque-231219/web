import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/Repository/contact_us_repo.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/contact_us_model/contact_us_model.dart';

class ContactUsService implements ContactUsRepository {
  final Dio dio;

  ContactUsService({required this.dio});

  @override
  Future contactAdmin(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.contactus, data: req);
      ContactUSModel contactUSModel = ContactUSModel.fromJson(response.data);
      return contactUSModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: 'Warning!', message: msg);
    }
  }
}
