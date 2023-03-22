class AddTaskModelData {
  int? userId;
  String? projectId;
  String? referenceId;
  String? date;
  String? image;
  String? description;
  String? reportId;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddTaskModelData({
    this.userId,
    this.projectId,
    this.referenceId,
    this.date,
    this.image,
    this.description,
    this.reportId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  AddTaskModelData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toInt();
    projectId = json['project_id']?.toString();
    referenceId = json['reference_id']?.toString();
    date = json['date']?.toString();
    image = json['image']?.toString();
    description = json['description']?.toString();
    reportId = json['report_id']?.toString();
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
    id = json['id']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['project_id'] = projectId;
    data['reference_id'] = referenceId;
    data['date'] = date;
    data['image'] = image;
    data['description'] = description;
    data['report_id'] = reportId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

class AddTaskModel {

  bool? success;
  String? message;
  AddTaskModelData? data;

  AddTaskModel({
    this.success,
    this.message,
    this.data,
  });

  AddTaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? AddTaskModelData.fromJson(json['data']) : null;
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
