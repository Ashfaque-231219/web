import 'dart:core';
// import 'dart:html' as html;
import 'dart:js' as js;

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/route_generator.dart';

class CommonMethods {
  static String version = '';
  static String appBadgeSupported = '';
  static int userId = 0, companyId = 0, userRoleId = 0;
  static String companyName = '', userRole = '';

  static showNetworkDialog(context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(appDimen.sp10),
                  child: Image.asset(
                    appImages.info,
                    // appImages.noInternet,
                    height: 44,
                    width: 44,
                  ),
                ),
                Text(
                  'No Internet',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: appDimen.sp18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: appDimen.sp10,
                ),
                Text(
                  'Please Check Your Internet Connection!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: appDimen.sp12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('ok'),
                  onPressed: () {
                    context.router.navigateBack();
                  })
            ],
          );
        });
  }

  static dismissKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void moveCursorToLastPos(TextEditingController textField) {
    var cursorPos = TextSelection.fromPosition(TextPosition(offset: textField.text.length));
    textField.selection = cursorPos;
  }

  static bool validateEmail(String value) {
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validateUrl(String url) {
    String pattern = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(url)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d#$@!%&*?]{8,20}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]{1,2})))$');

    return numericRegex.hasMatch(string);
  }

  static bool isImagePngJpeg(String value) {
    // final pattern = "image/png"  " image/jpeg";
    if (value == "image/png" || value == "image/jpeg" || value == "image/jpg") {
      return true;
    } else {
      return false;
    }
  }

  static void inputFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static bool isAlphanumericRegularExpression(String string) {
    final pattern = RegExp(r'^[a-zA-Z0-9]+$');
    return pattern.hasMatch(string);
  }

  bool isConnect = false;

  static callLoader(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()));
      },
    );
  }

  static void showToast(BuildContext context, String message, bool status) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: status ? Colors.green : Colors.red,
    ));
  }

  static getStatusColor(String? status) {
    if (status != null && status == 'cancel') {
      return Color(appColors.blue002060);
    } else if (status != null && status == 'completed') {
      return Color(appColors.grey312A2AB3);
    } else {
      return Color(appColors.orangeF7941E);
    }
  }

  static Future<DateTime> selectDate(BuildContext context, selectedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      return picked;
    } else {
      return selectedDate;
    }
  }

  static String dateFormatterYMDTime(String date) {
    DateFormat df = DateFormat("dd MMM, yyyy 'at' hh:mm a");
    return df.format(DateFormat("yyyy-MM-dd HH:mm").parse(date));
  }

  static String dateFormatterTime(String date) {
    DateFormat df = DateFormat.jm();
    return df.format(DateFormat("yyyy-MM-dd HH:mm").parse(date));
  }

  static String dateFormatterTimes(String datetime) {
    var date = DateTime.parse(datetime == "" ? "yyyy-MM-ddTHH:mm" : datetime);
    DateFormat df = DateFormat("HH:mm");
    return df.format(date).toLowerCase();
  }

  static String dateFormatterYMD(
    String date, {
    String? inputFormat,
  }) {
    DateFormat df = DateFormat("dd MMM, yyyy");
    return df.format(DateFormat(inputFormat ?? "yyyy-MM-dd HH:mm").parse(date));
  }

  static String dateFormatterYMDate(String date, {String? inputFormat}) {
    DateFormat df = DateFormat("dd MMM yyyy");
    return df.format(DateFormat(inputFormat ?? "yyyy-MM-dd HH:mm").parse(date));
  }

  static String formatDateToString(String datetime) {
    var date = DateTime.parse(datetime == "" ? "yyyy-MM-ddTHH:mm" : datetime);
    var dateformatter = DateFormat("dd MMM yyyy");
    var formatedDate = dateformatter.format(date);
    return formatedDate;
  }

  static String dateFormatterYYYYMMDD(String date, {String? inputFormat}) {
    DateFormat df = DateFormat("dd-MMM-yyyy");
    return df.format(DateFormat(inputFormat ?? "yyyy-MM-dd HH:mm").parse(date));
  }

  static String dateFormatterDDMMYYYY(String date, {String? inputFormat}) {
    DateFormat df = DateFormat("dd/MM/yyyy");
    return df.format(DateFormat(inputFormat ?? "yyyy-MM-dd HH:mm").parse(date));
  }

  static String dateFormatterYYYMMDD(String date) {
    var inputFormat = DateFormat("yyyy-MM-dd");

    return inputFormat.format(DateFormat("yyyy-MM-dd").parse(date));
  }

  static String dateWithDay(String date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    DateFormat df = DateFormat("dd MMMM yyyy");

    final dateToCheck = DateTime.parse(date);
    final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    String formattedDate = df.format(DateFormat("yyyy-MM-dd HH:mm").parse(date));
    if (aDate == today) {
      return "Today, $formattedDate";
    } else if (aDate == yesterday) {
      return "Yesterday, $formattedDate";
    } else if (aDate == tomorrow) {
      return "Tomorrow, $formattedDate";
    } else {
      return formattedDate;
    }
  }

  /// Fetch stored page. Display default page if null.
  static Future<String> getCurrentPage() async {
    var pref = await SharedPreferences.getInstance();
    print("CurrentPage");
    print(pref.getString(SharedPref.currentPage) ?? RoutesConst.homePage + RoutesConst.projects);
    return pref.getString(SharedPref.currentPage) ?? RoutesConst.homePage + RoutesConst.projects;
  }

  /// Store current [page] to restore into during page refresh on web
  static Future<void> setCurrentPage(String page) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(SharedPref.currentPage, page);
  }

  static shareMail(String to, String subject, String message, String cc) async {
    final url = 'mailto:$to?cc=${Uri.encodeFull(cc)}&subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  static saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/PDF_Download";
        directory = Directory(newPath);

        File saveFile = File("${directory.path}/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<File> downloadFile(String url, String filename) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename.${url.split(".").last}');
    await file.writeAsBytes(bytes);
    return file;
  }

  static download(String url) {
    if(url.isNotEmpty) {
      // html.AnchorElement anchorElement = html.AnchorElement(href: url);
      // anchorElement.download = url;
      // anchorElement.click();

      js.context.callMethod('open', [url]);
      // html.window.open(url, url);
    }
  }

  Future<dynamic> pickImage(BuildContext context) async {
    if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        debugPrint(image.mimeType);
        print("fileExtension");
        print(image.path);
        if (CommonMethods.isImagePngJpeg(image.mimeType.toString())) {
          return f;
        } else {
          showErrorSnackBar(context, "Image Type is not supported. Supported Types are jpg,jpeg and png).");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else {
      debugPrint('Something went wrong');
    }
  }

  Future<dynamic> pickVideo(BuildContext context) async {
    if (kIsWeb) {
      final ImagePicker videoPicker = ImagePicker();
      XFile? video = await videoPicker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        var selected = File(video.path);
        if (video.mimeType.toString() == "video/mp4") {
          return selected;
        } else {
          showErrorSnackBar(context, "Video Type is not supported. Supported Type is mp4.");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else {
      debugPrint('Something went wrong');
    }
  }
}

Future<void> openUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
