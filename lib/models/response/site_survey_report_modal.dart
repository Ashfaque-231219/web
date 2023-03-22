class SiteSurveyModal {
  bool? success;
  String? message;
  SiteSurveyModalData? data;

  SiteSurveyModal({
    this.success,
    this.message,
    this.data,
  });

  SiteSurveyModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? SiteSurveyModalData.fromJson(json['data']) : null;
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

class SiteSurveyModalData {
  int? userId;
  String? projectId;
  String? length;
  String? width;
  String? area;
  String? onloadingLocation;
  String? offloadingLocation;
  String? reportCategoryId;
  String? description;
  String? layoutPlanImage;
  String? the360DegreeImage;
  String? updatedAt;
  String? createdAt;
  int? id;

  SiteSurveyModalData({
    this.userId,
    this.projectId,
    this.length,
    this.width,
    this.area,
    this.onloadingLocation,
    this.offloadingLocation,
    this.reportCategoryId,
    this.description,
    this.layoutPlanImage,
    this.the360DegreeImage,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  SiteSurveyModalData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toInt();
    projectId = json['project_id']?.toString();
    length = json['length']?.toString();
    width = json['width']?.toString();
    area = json['area']?.toString();
    onloadingLocation = json['onloading_location']?.toString();
    offloadingLocation = json['offloading_location']?.toString();
    reportCategoryId = json['report_category_id']?.toString();
    description = json['description']?.toString();
    layoutPlanImage = json['layout_plan_image']?.toString();
    the360DegreeImage = json['360_degree_image']?.toString();
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
    id = json['id']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['project_id'] = projectId;
    data['length'] = length;
    data['width'] = width;
    data['area'] = area;
    data['onloading_location'] = onloadingLocation;
    data['offloading_location'] = offloadingLocation;
    data['report_category_id'] = reportCategoryId;
    data['description'] = description;
    data['layout_plan_image'] = layoutPlanImage;
    data['360_degree_image'] = the360DegreeImage;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
