import 'package:flutter/material.dart';

abstract class ScheduleEvent {
  ScheduleEvent();

  List<Object?> get props => [];
}

class AddScheduleEvent extends ScheduleEvent {
  final BuildContext? context;
  final String? projectId;
  final String? date;
  final String? description;

  AddScheduleEvent({
    this.context,
    this.projectId = '',
    this.description = '',
    this.date = '',
  });
}

class EditScheduleReportEvent extends ScheduleEvent {
  final BuildContext? context;
  final String? id;
  final String? date;
  final String? description;

  EditScheduleReportEvent({this.context, this.date = '', this.description = '', this.id = ''});
}

class DeleteScheduleReportEvent extends ScheduleEvent {
  final BuildContext? context;
  final String? id;
  final String? projectId;

  DeleteScheduleReportEvent({
    this.context,
    this.id,
    this.projectId = '',
  });
}

class ViewScheduleEvent extends ScheduleEvent {
  final BuildContext? context;
  final String? projectId;

  ViewScheduleEvent({
    this.context,
    this.projectId = '',
  });
}
