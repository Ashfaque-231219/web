import 'package:web/models/response/project_details_modal.dart';

class ViewInspectionReportModel {
  bool? success;
  List<TaskList?>? data;
  String? message;

  ViewInspectionReportModel({
    this.success,
    this.data,
    this.message,
  });

  ViewInspectionReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <TaskList>[];
      v.forEach((v) {
        arr0.add(TaskList.fromJson(v));
      });
      this.data = arr0;
    }
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['data'] = arr0;
    }
    data['message'] = message;
    return data;
  }
}
