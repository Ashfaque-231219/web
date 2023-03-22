import 'package:flutter/material.dart';

abstract class TaskReportEvent {
  TaskReportEvent();

  List<Object?> get props => [];
}

class AddTaskReportEvent extends TaskReportEvent {
  final BuildContext? context;
  final String? projectId;
  final String? date;
  final String? description;
  final String? image;

  AddTaskReportEvent({
    this.context,
    this.projectId = '',
    this.description = '',
    this.date = '',
    this.image = '',
  });
}

class EditTaskReportEvent extends TaskReportEvent {
  final BuildContext? context;
  final String? taskId;
  final String? date;
  final String? description;
  final String? image;

  EditTaskReportEvent({
    this.context,
    this.taskId = '',
    this.description = '',
    this.date = '',
    this.image = '',
  });
}

class DeleteTaskReportEvent extends TaskReportEvent {
  final BuildContext? context;
  final String? taskId;

  DeleteTaskReportEvent({
    this.context,
    this.taskId = '',
  });
}

class ViewTaskReportEvent extends TaskReportEvent {
  final BuildContext? context;
  final String? reportId;

  ViewTaskReportEvent({
    this.context,
    this.reportId = '',
  });
}
