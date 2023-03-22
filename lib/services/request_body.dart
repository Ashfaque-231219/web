class RequestBody {
  static Map projectList({String? search}) {
    return {
      'search': search,
    };
  }

  static Map reportList({String? search}) {
    return {
      'report_name': search,
    };
  }

  static Map projectDetails(
      {String? projectId, String? search, String? maintenanceSearch, String? punchSearch}) {
    return {
      'project_id': projectId,
      'report_search': search,
      'maintenance_search': maintenanceSearch,
      'punchList_search': punchSearch,
    };
  }

  static Map projectInfo({String? projectId}) {
    return {
      'project_id': projectId,
    };
  }

  static Map addSiteSurveyReport({
    String? projectId,
    String? length,
    String? width,
    String? area,
    String? onLoadingLocation,
    String? offLoadingLocation,
    int? reportCategoryId,
    String? description,
    String? layoutPlanImage,
    String? image360Degree,
    bool? videoType,
  }) {
    Map req = {
      'project_id': projectId,
      'length': length,
      'width': width,
      'area': area,
      'onloading_location': onLoadingLocation,
      'offloading_location': offLoadingLocation,
      'report_category_id': reportCategoryId,
      'description': description,
      // 'layout_plan_image': layoutPlanImage,
      // 'image_360_degree': image360Degree,
      'video_type': videoType,
      'type': 'web',
    };
    if (layoutPlanImage != null && layoutPlanImage.isNotEmpty) {
      req.addAll({'layout_plan_image': layoutPlanImage});
    }
    if (image360Degree != null && image360Degree.isNotEmpty) {
      req.addAll({'image_360_degree': image360Degree});
    }

    return req;
  }

  static Map viewSiteSurveyReport({
    int? reportId,
  }) {
    return {
      'report_id': reportId,
    };
  }

  static Map editSiteSurveyReport({
    int? id,
    String? projectId,
    String? length,
    String? width,
    String? area,
    String? onLoadingLocation,
    String? offLoadingLocation,
    int? reportCategoryId,
    String? description,
    String? layoutPlanImage,
    String? image360Degree,
    bool? videoType,
  }) {
    Map req = {
      'id': id,
      'project_id': projectId,
      'length': length,
      'width': width,
      'area': area,
      'onloading_location': onLoadingLocation,
      'offloading_location': offLoadingLocation,
      'report_category_id': reportCategoryId,
      'description': description,
      // 'layout_plan_image': layoutPlanImage,
      // 'image_360_degree': image360Degree,
      'video_type': videoType,
      'type': 'web',
    };

    if (layoutPlanImage != null && layoutPlanImage.isNotEmpty) {
      req.addAll({'layout_plan_image': layoutPlanImage});
    }
    if (image360Degree != null && image360Degree.isNotEmpty) {
      req.addAll({'image_360_degree': image360Degree});
    }

    return req;
  }

  static Map addPunchList(
      {int? projectId, String? punchListId, String? image, String? date, String? description}) {
    return {
      'project_id': projectId,
      'punch_list_id': punchListId,
      'before_image': image,
      'expected_completion_date': date,
      'before_description': description,
      'type': 'web',
    };
  }

  static Map editPunchList({int? punchListId, String? image, String? description}) {
    return {
      'id': punchListId,
      'after_image': image,
      'after_description': description,
      'type': 'web',
    };
  }

  static Map viewPunchList({int? punchListId}) {
    return {
      'punch_list_id': punchListId,
    };
  }

  static Map getProjectStatus({int? projectId}) {
    return {
      'project_id': projectId,
    };
  }

  static Map contactAdmin({String? question}) {
    return {
      'question': question,
    };
  }

  static Map addMaintenance(
      {String? beforeImage,
      String? maintenanceId,
      String? projectId,
      String? beforeDescription,
      bool? videoType}) {
    return {
      'before_image': beforeImage,
      'project_id': projectId,
      'before_description': beforeDescription,
      'video_type': videoType,
      'type': 'web',
      'maintenance_list_id': maintenanceId,
    };
  }

  static Map resolveMaintenance(
      {String? afterImage, String? id, String? afterDescription, bool? videoType}) {
    return {
      'id': id,
      'after_image': afterImage,
      'after_description': afterDescription,
      'video_type': videoType,
      'type': 'web',
    };
  }

  static Map viewMaintenance({String? id}) {
    return {
      'list_id': id,
    };
  }

  static Map addSchedule({String? projectId, String? description, String? date}) {
    return {'project_id': projectId, 'description': description, 'date': date};
  }

  static Map editSchedule({String? scheduleId, String? description, String? date}) {
    return {'id': scheduleId, 'description': description, 'date': date};
  }

  static Map deleteSchedule({
    String? scheduleId,
  }) {
    return {
      'id': scheduleId,
    };
  }

  static Map viewSchedule({
    String? projectId,
  }) {
    return {
      'project_id': projectId,
    };
  }

  static Map addTaskReport({String? projectId, String? description, String? date, String? image}) {
    return {
      'project_id': projectId,
      'report_category_id': "2",
      'description': description,
      'date': date,
      'image': image,
      'image_type': 'web',
    };
  }

  static Map editTaskReport({String? taskId, String? description, String? date, String? image}) {
    return image != null && image.isNotEmpty
        ? {
            'id': taskId,
            'description': description,
            'date': date,
            'image': image,
            'image_type': 'web',
          }
        : {
            'id': taskId,
            'description': description,
            'date': date,
          };
  }

  static Map deleteTaskReport({String? taskId}) {
    return {
      'id': taskId,
    };
  }

  static Map viewTaskReport({String? reportId}) {
    return {
      'report_id': reportId,
    };
  }

  static Map generateTaskReport({String? projectId}) {
    return {
      'project_id': projectId,
    };
  }

  static Map notificationList({int? userId}) {
    return {
      'user_id': userId,
    };
  }

  static Map getReportUsers({
    List<String>? reportId,
    String? reportType,
  }) {
    return {
      'report_id': reportId,
      'type': reportType,
    };
  }

  static Map shareReport({
    List<String>? reportId,
    List<String>? mailId,
    String? reportType,
  }) {
    return {
      'id': reportId,
      'user_email': mailId,
      'type': reportType,
    };
  }
}
