import 'package:flutter/material.dart';

abstract class AuthRepo{
  Future loginService(Map<String, dynamic> req, BuildContext context);
  Future forgotService(Map<String, dynamic> req,BuildContext context);
  Future otpService(Map<String, dynamic> req,BuildContext context);
  Future resetService(Map<String, dynamic> req,BuildContext context);
  Future changePassService(Map<String, dynamic> req,BuildContext context);
  Future statusCode(Map<String, dynamic> req,BuildContext context);
  Future editService(Map<String, dynamic> req,BuildContext context);
  Future getUserService(BuildContext context);
  Future reportType(BuildContext context);
  Future logoutService();
}