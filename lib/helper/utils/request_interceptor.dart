import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';

import '../constants/api_constants.dart';

//! Dio Interceptor Setup
class RequestInterceptor extends Interceptor {
  //* Start of RequestInterceptor class */

  final Dio api = Dio();

  //* ============================ On-Request =====================
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    printError('REQUEST[${options.method}] => ${options.uri}');
    //Get saved tokens from local storage
    String savedTokens = await SharedPref.getString(key: "token");
    debugPrint("The saved token is $savedTokens");
    if (savedTokens.isNotEmpty) {
      options.headers["Authorization"] = 'Bearer $savedTokens';
    }
    return super.onRequest(options, handler);
  }

  //* ============================ On-Error =====================

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    printError("=== Dio Error Occured ==> ErrorResponse[${err.response?.statusCode}] ===");
    if (err.type == DioErrorType.response) {
      printError('ErrorResponse[${err.response?.statusCode}] =>${err.response}');
      SharedPref.setInt(key: 'error-code', data: err.response?.statusCode??0);
      SharedPref.setString(key: 'error-msg', data: err.response?.data['message']??'');
      printError("error::::::${err.response?.data["message"]}");
    }
    if (err.type == DioErrorType.connectTimeout) {
      printError('check your connection');
      SharedPref.setString(key: 'error-msg', data: 'Check your connection');
    }

    if (err.type == DioErrorType.receiveTimeout) {
      printError('unable to connect to the server');
    }

    if (err.type == DioErrorType.other) {
      printError('Something went wrong');
    }
    // consider to remap this error to generic error.
    return super.onError(err, handler);
  }

  //* ============================ On-Response =====================

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    printError("=== Dio Success Occured ==> RESPONSE[${response.statusCode}] ===");
    dynamic res = response.data is! List ? json.decode(response.data is String ? response.data : json.encode(response.data)) : null;
    /* Check token expire or not */
    if (res != null && res["success"] != null && res["session_expired"] != null && !res["success"] && res?["session_expired"]) {}
    return super.onResponse(response, handler);
  }

  //* Retry Request after refreshing token */

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,

    );
    String savedTokens = await SharedPref.getString(key: SharedPref.prefTokens);
    if (savedTokens.isNotEmpty) {
      options.headers!["Authorization"] = 'Bearer $savedTokens';
    }
    return api.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
//* End of Interceptor class */
}

//! ========================= Dio Client Setup ===========================
class DioClient {
  final Dio _dio = Dio();
  final String _baseUrl = ApiConstants.baseURL;
  final RequestInterceptor requestInterceptor = RequestInterceptor();

  DioClient();

  BaseOptions _dioOptions() {
    BaseOptions opts = BaseOptions();
    opts.baseUrl = _baseUrl;
    opts.connectTimeout = 60000;
    opts.receiveTimeout = 60000;
    opts.sendTimeout = 60000;
    return opts;
  }

  Dio provideDio() {
    _dio.options = _dioOptions();
    _dio.interceptors.add(requestInterceptor);
    return _dio;
  }
}
