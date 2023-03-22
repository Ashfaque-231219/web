class ViewScheduleModelData {
  int? id;
  String? referenceId;
  int? projectId;
  int? userId;
  String? date;
  String? description;
  String? createdAt;
  String? updatedAt;

  ViewScheduleModelData({
    this.id,
    this.referenceId,
    this.projectId,
    this.userId,
    this.date,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  ViewScheduleModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
    date = json['date']?.toString();
    description = json['description']?.toString();
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
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ViewScheduleModel {
  bool? success;
  ViewScheduleModelData? data;
  String? message;

  ViewScheduleModel({
    this.success,
    this.data,
    this.message,
  });

  ViewScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] != null) ? ViewScheduleModelData.fromJson(json['data']) : null;
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}
