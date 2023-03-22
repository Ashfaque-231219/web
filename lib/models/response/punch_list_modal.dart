class Data {
  int? id;
  String? referenceId;
  String? punchListId;
  int? projectId;
  int? userId;
  String? beforeImage;
  String? beforeDescription;
  String? expectedCompletionDate;
  String? afterImage;
  String? afterDescription;
  String? actualCompletionDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.referenceId,
    this.punchListId,
    this.projectId,
    this.userId,
    this.beforeImage,
    this.beforeDescription,
    this.expectedCompletionDate,
    this.afterImage,
    this.afterDescription,
    this.actualCompletionDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    punchListId = json['punch_list_id']?.toString();
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
    beforeImage = json['before_image']?.toString();
    beforeDescription = json['before_description']?.toString();
    expectedCompletionDate = json['expected_completion_date']?.toString();
    afterImage = json['after_image']?.toString();
    afterDescription = json['after_description']?.toString();
    actualCompletionDate = json['actual_completion_date']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['reference_id'] = referenceId;
    data['punch_list_id'] = punchListId;
    data['project_id'] = projectId;
    data['user_id'] = userId;
    data['before_image'] = beforeImage;
    data['before_description'] = beforeDescription;
    data['expected_completion_date'] = expectedCompletionDate;
    data['after_image'] = afterImage;
    data['after_description'] = afterDescription;
    data['actual_completion_date'] = actualCompletionDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PunchListModal {
  bool? success;
  String? message;
  Data? data;

  PunchListModal({
    this.success,
    this.message,
    this.data,
  });

  PunchListModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
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
