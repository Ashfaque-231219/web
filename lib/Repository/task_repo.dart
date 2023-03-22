import 'package:flutter/material.dart';

abstract class TaskRepository {
  Future addTaskReport(Map req, BuildContext context);
  Future editTaskReport(Map req, BuildContext context);
  Future deleteTaskReport(Map req, BuildContext context);
  Future viewTaskReport(Map req, BuildContext context);
}
