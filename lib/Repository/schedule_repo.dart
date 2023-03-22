import 'package:flutter/material.dart';

abstract class ScheduleRepository {
  Future addSchedule(Map req, BuildContext context);
  Future viewSchedule(Map req, BuildContext context);
  Future editSchedule(Map req, BuildContext context);
  Future deleteSchedule(Map req, BuildContext context);

}
