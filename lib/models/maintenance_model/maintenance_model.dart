class MaintenanceModelData {
  int? id;
  String? referenceId;
  String? maintenanceListId;
  int? projectId;
  int? userId;
  String? beforeImage;
  String? beforeDescription;
  String? afterImage;
  String? afterDescription;
  String? status;
  String? createdAt;
  String? updatedAt;

  MaintenanceModelData({
    this.id,
    this.referenceId,
    this.maintenanceListId,
    this.projectId,
    this.userId,
    this.beforeImage,
    this.beforeDescription,
    this.afterImage,
    this.afterDescription,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  MaintenanceModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    maintenanceListId = json['maintenance_list_id']?.toString();
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
    beforeImage = json['before_image']?.toString();
    beforeDescription = json['before_description']?.toString();
    afterImage = json['after_image']?.toString();
    afterDescription = json['after_description']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['reference_id'] = referenceId;
    data['maintenance_list_id'] = maintenanceListId;
    data['project_id'] = projectId;
    data['user_id'] = userId;
    data['before_image'] = beforeImage;
    data['before_description'] = beforeDescription;
    data['after_image'] = afterImage;
    data['after_description'] = afterDescription;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class MaintenanceModel {
  bool? success;
  String? message;
  MaintenanceModelData? data;

  MaintenanceModel({
    this.success,
    this.message,
    this.data,
  });

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? MaintenanceModelData.fromJson(json['data']) : null;
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
