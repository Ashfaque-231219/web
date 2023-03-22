import 'package:flutter/material.dart';

abstract class ShareRepository {
  Future shareReportUsers(Map req, BuildContext context);
  Future shareReportsMail(Map req, BuildContext context);
}
