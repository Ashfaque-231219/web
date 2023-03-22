class ScheduleModelData {
  int? userId;
  String? projectId;
  String? referenceId;
  String? date;
  String? description;
  String? updatedAt;
  String? createdAt;
  int? id;

  ScheduleModelData({
    this.userId,
    this.projectId,
    this.referenceId,
    this.date,
    this.description,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  ScheduleModelData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toInt();
    projectId = json['project_id']?.toString();
    referenceId = json['reference_id']?.toString();
    date = json['date']?.toString();
    description = json['description']?.toString();
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
    data['description'] = description;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

class ScheduleModel {
  bool? success;
  String? message;
  ScheduleModelData? data;

  ScheduleModel({
    this.success,
    this.message,
    this.data,
  });

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? ScheduleModelData.fromJson(json['data']) : null;
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
