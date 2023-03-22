import 'dart:html';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:web/helper/constants/image_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/route_generator.dart';

import '../constants/color_constants.dart';
import '../constants/font_family.dart';

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

Map getCookiesData() {
  Map cookieMap = {};
  final cookie = document.cookie!;
  if (cookie.isNotEmpty) {
    final entity = cookie.split("; ").map((item) {
      final split = item.split("=");
      return MapEntry(split[0], split[1]);
    });
    cookieMap = Map.fromEntries(entity);
  }

  return cookieMap;
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        height: MediaQuery.of(context).size.width * 0.1,
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.lightGreenAccent, Colors.green])),
        child: Center(
          child: Text(
            message,
            style: TextStyle(fontFamily: FontFamily.montserrat, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        )),
    padding: EdgeInsets.zero,
    duration: const Duration(milliseconds: 1300),
  ));
}

checkStatus(BuildContext context) async {
  var msg = await SharedPref.getString(key: "error-msg");
  if(msg.isNotEmpty) {
    showCustomAlert(context: context, title: 'Warning!', message: msg);
  }else{
    showCustomAlert(context: context, title: 'Warning!', message: 'Something went Wrong!\nPlease Refresh the page to Retry.');
  }
  var statusCode = await SharedPref.getInt(key: 'error-code');
  debugPrint("THe status code is ========>>>>>>>>>>>>>>>>>>>>>>> $statusCode");
  if (statusCode == 401) {
    await SharedPref.setBool(key: "logout", data: true);
    Future.delayed(Duration.zero, () {
      context.router.popUntilRoot();
      context.router.pushNamed(RoutesConst.login);
      // Navigator.pushNamedAndRemoveUntil(context, RoutesConst.login, (route) => false);
    });
  }
}

void printLog(String text) {
  debugPrint('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  debugPrint('\x1B[31m$text\x1B[0m');
}

String formatDateToString(String datetime, String format) {
  var date = DateTime.parse(datetime == "" ? '1999-02-01 12:45:25.123456' : datetime);
  var dateformatter = DateFormat(format);
  var formatedDate = dateformatter.format(date);
  return formatedDate;
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.deepOrangeAccent,
        ),
        child: Text(
          message,
          style: TextStyle(fontFamily: FontFamily.montserrat, fontSize: 14, fontWeight: FontWeight.w600),
        )),
    padding: EdgeInsets.zero,
    duration: const Duration(milliseconds: 1300),
  ));
}

void showCustomAlert({
  required BuildContext context,
  required String title,
  required String message,
  bool showNegativeButton = true,
  bool notification = false,
}) {
  showDialog(
      context: context,
      barrierDismissible: notification,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: SizedBox(
              height: 50,
              width: 100,
              child: Center(
                child: notification
                    ? Lottie.asset(
                        ImageConstants.notification,
                        repeat: true,
                      )
                    : Lottie.asset(
                        ImageConstants.warning,
                        repeat: true,
                      ),
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            content: SizedBox(
              height: 150,
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    " $title!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.darkBrown,
                          ),
                          width: 80,
                          height: 30,
                          child: const Center(
                            child: Text(
                              'Ok',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
