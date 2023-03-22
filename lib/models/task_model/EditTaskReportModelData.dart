class EditTaskReportModelData {
  int? id;
  String? referenceId;
  int? projectId;
  int? userId;
  String? date;
  String? image;
  String? description;
  String? reportId;
  String? status;
  String? pdfUrl;
  String? createdAt;
  String? updatedAt;

  EditTaskReportModelData({
    this.id,
    this.referenceId,
    this.projectId,
    this.userId,
    this.date,
    this.image,
    this.description,
    this.reportId,
    this.status,
    this.pdfUrl,
    this.createdAt,
    this.updatedAt,
  });

  EditTaskReportModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
    date = json['date']?.toString();
    image = json['image']?.toString();
    description = json['description']?.toString();
    reportId = json['report_id']?.toString();
    status = json['status']?.toString();
    pdfUrl = json['pdf_url']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['reference_id'] = referenceId;
    data['project_id'] = projectId;
    data['user_id'] = userId;
    data['date'] = date;
    data['image'] = image;
    data['description'] = description;
    data['report_id'] = reportId;
    data['status'] = status;
    data['pdf_url'] = pdfUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class EditTaskReportModel {
  bool? success;
  String? message;
  EditTaskReportModelData? data;

  EditTaskReportModel({
    this.success,
    this.message,
    this.data,
  });

  EditTaskReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? EditTaskReportModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
