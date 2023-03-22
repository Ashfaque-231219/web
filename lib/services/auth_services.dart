import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:web/Repository/auth_repo.dart';
import 'package:web/helper/constants/api_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/models/response/OTPModel/otp_model.dart';
import 'package:web/models/response/get_report_type.dart';
import 'package:web/models/response/get_user_model.dart';

import '../helper/utils/utils.dart';
import '../models/response/ForgotPassModel/forgot_pass_model.dart';
import '../models/response/changePasswordModel/change_pass_model.dart';
import '../models/response/editModel/edit_model.dart';
import '../models/response/loginModel/login_model.dart';
import '../models/response/logoutModel/logout_model.dart';
import '../models/response/resetPasswordModel/reset_model.dart';

class AuthService implements AuthRepo {
  final Dio dio;

  AuthService({required this.dio});

  @override
  Future loginService(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.login, data: req);
      debugPrint("======${response.data}");
      SharedPref.setString(key: "error-msg", data: response.data['message']);
      LoginModel loginModel = LoginModel.fromJson(response.data);
      // SharedPref.setString(key: "token-id", data: loginModel.token!);
      debugPrint("object:::::$loginModel");
      return loginModel;
    } catch (e) {
      var msg = await SharedPref.getString(key: "error-msg");
      showCustomAlert(context: context, title: "Warning", message: msg);
      // showErrorSnackBar(context, msg);
    }
  }

  @override
  Future forgotService(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.sendOtp, data: req);
      debugPrint("object:::;${SharedPref.setString(key: "error-msg", data: response.data['message'])}");
      ForgotPass forgotPass = ForgotPass.fromJson(response.data);
      debugPrint("object:$forgotPass");
      return forgotPass;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future otpService(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.verifyOtp, data: req);
      debugPrint("object:::;${SharedPref.setString(key: "error-msg", data: response.data['message'])}");
      OTPVerify otpVerify = OTPVerify.fromJson(response.data);
      return otpVerify;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future logoutService() async {
    try {
      Response response = await dio.post(
        ApiConstants.logout,
      );
      Logout logout = Logout.fromJson(response.data);
      return logout;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future resetService(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.reset, data: req);
      debugPrint("object:::;${SharedPref.setString(key: "error-msg", data: response.data['message'])}");
      ResetModel resetModel = ResetModel.fromJson(response.data);
      return resetModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future changePassService(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.changePass, data: req);
      ChangePass changePass = ChangePass.fromJson(response.data);
      return changePass;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future statusCode(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.login, data: req);
      // LoginModel changePass = LoginModel.fromJson(response.data);
      return response.statusCode;
    } catch (e) {
      checkStatus(context);
      debugPrint(e.toString());
    }
  }

  @override
  Future editService(Map<String, dynamic> req, BuildContext context) async {
    try {
      var image = req["image"];
      if (image != null && image.toString().isNotEmpty) {
        FormData formData = FormData.fromMap({'name': req['name'], 'image': req['image'], 'type': req['type']});
        Response response = await dio.post(ApiConstants.updateProfile, data: formData);
        EditModel editModel = EditModel.fromJson(response.data);
        if (editModel.success == true) {
          Future.delayed(Duration.zero, () => showSnackBar(context, editModel.message!));
          return editModel;
        }
      } else {
        Response response = await dio.post(ApiConstants.updateProfile, data: req);
        EditModel editModel = EditModel.fromJson(response.data);
        if (editModel.success == true) {
          Future.delayed(Duration.zero, () => showSnackBar(context, editModel.message!));
          return editModel;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future getUserService(BuildContext context) async {
    try {
      Response response = await dio.post(ApiConstants.getUserDetails);
      GetUserModel getUserModel = GetUserModel.fromJson(response.data);
      return getUserModel;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }

  @override
  Future reportType(BuildContext context) async {
    try {
      Response response = await dio.get(ApiConstants.getReportType);
      ReportTypeModel reportType = ReportTypeModel.fromJson(response.data);
      return reportType;
    } catch (e) {
      debugPrint(e.toString());
      checkStatus(context);
    }
  }
}
