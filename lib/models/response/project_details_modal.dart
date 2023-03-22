class TaskList {
  int? id;
  String? referenceId;
  int? projectId;
  int? userId;
  String? date;
  String? image;
  String? description;
  String? reportId;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? reportCategoryId;
  String? pdfUrl;

  TaskList({
    this.id,
    this.referenceId,
    this.projectId,
    this.userId,
    this.date,
    this.image,
    this.description,
    this.reportId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.reportCategoryId,
    this.pdfUrl,
  });

  TaskList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
    date = json['date']?.toString();
    image = json['image']?.toString();
    description = json['description']?.toString();
    reportId = json['report_id']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    pdfUrl = json['pdf_url']?.toString();
    reportCategoryId = json['report_category_id']?.toInt();
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['report_category_id'] = reportCategoryId;
    data['pdf_url'] = pdfUrl;
    return data;
  }
}

class ScheduleList {
  int? id;
  String? referenceId;
  int? projectId;
  int? userId;
  String? date;
  String? description;
  String? createdAt;
  String? updatedAt;

  ScheduleList({
    this.id,
    this.referenceId,
    this.projectId,
    this.userId,
    this.date,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  ScheduleList.fromJson(Map<String, dynamic> json) {
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

class PunchLists {
  int? id;
  String? referenceId;
  String? punchListId;
  int? projectId;
  String? pdfUrl;
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

  PunchLists({
    this.id,
    this.referenceId,
    this.punchListId,
    this.projectId,
    this.pdfUrl,
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

  PunchLists.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    punchListId = json['punch_list_id']?.toString();
    projectId = json['project_id']?.toInt();
    pdfUrl = json['pdf_url']?.toString();
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
    data['pdf_url'] = pdfUrl;
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

class Maintenance {
  int? id;
  String? referenceId;
  String? maintenanceListId;
  String? pdfUrl;
  int? projectId;
  int? userId;
  String? beforeImage;
  String? beforeDescription;
  String? afterImage;
  String? afterDescription;
  String? status;
  String? createdAt;
  String? updatedAt;

  Maintenance({
    this.id,
    this.referenceId,
    this.maintenanceListId,
    this.pdfUrl,
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

  Maintenance.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    maintenanceListId = json['maintenance_list_id']?.toString();
    pdfUrl = json['pdf_url']?.toString();
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
    data['pdf_url'] = pdfUrl;
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

class Reports {
  String? name;
  String? createdAt;
  int? id;
  int? projectId;
  String? pdfUrl;
  String? reportId;
  int? reportCategoryId;

  Reports({this.name, this.createdAt, this.id, this.reportId, this.reportCategoryId, this.pdfUrl, this.projectId});

  Reports.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    createdAt = json['created_at']?.toString();
    id = json['id'];
    projectId = json['project_id'];
    pdfUrl = json['pdf_url'];
    reportId = json['report_id'];
    reportCategoryId = json['report_category_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['report_id'] = reportId;
    data['report_category_id'] = reportCategoryId;
    data['project_id'] = projectId;
    data['pdf_url'] = pdfUrl;
    return data;
  }
}

class ProjectImages {
  int? id;
  int? projectId;
  String? image;
  String? createdAt;
  String? updatedAt;

  ProjectImages({
    this.id,
    this.projectId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  ProjectImages.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    projectId = json['project_id']?.toInt();
    image = json['image']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UsersPivot {
  int? projectId;
  int? userId;

  UsersPivot({
    this.projectId,
    this.userId,
  });

  UsersPivot.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['user_id'] = userId;
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  String? employeeId;
  String? userRoleId;
  String? phone;
  String? officeNumber;
  String? address;
  String? photo;
  String? brand;
  String? position;
  String? team;
  String? region;
  int? countryId;
  String? otp;
  int? isVerified;
  String? status;
  String? deviceToken;
  String? deviceType;
  String? updatedAt;
  String? createdAt;
  UsersPivot? pivot;

  Users({
    this.id,
    this.name,
    this.email,
    this.employeeId,
    this.userRoleId,
    this.phone,
    this.officeNumber,
    this.address,
    this.photo,
    this.brand,
    this.position,
    this.team,
    this.region,
    this.countryId,
    this.otp,
    this.isVerified,
    this.status,
    this.deviceToken,
    this.deviceType,
    this.updatedAt,
    this.createdAt,
    this.pivot,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    employeeId = json['employee_id']?.toString();
    userRoleId = json['user_role_id']?.toString();
    phone = json['phone']?.toString();
    officeNumber = json['office_number']?.toString();
    address = json['address']?.toString();
    photo = json['photo']?.toString();
    brand = json['brand']?.toString();
    position = json['position']?.toString();
    team = json['team']?.toString();
    region = json['region']?.toString();
    countryId = json['country_id']?.toInt();
    otp = json['otp']?.toString();
    isVerified = json['is_verified']?.toInt();
    status = json['status']?.toString();
    deviceToken = json['device_token']?.toString();
    deviceType = json['device_type']?.toString();
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
    pivot = (json['pivot'] != null) ? UsersPivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['employee_id'] = employeeId;
    data['user_role_id'] = userRoleId;
    data['phone'] = phone;
    data['office_number'] = officeNumber;
    data['address'] = address;
    data['photo'] = photo;
    data['brand'] = brand;
    data['position'] = position;
    data['team'] = team;
    data['region'] = region;
    data['country_id'] = countryId;
    data['otp'] = otp;
    data['is_verified'] = isVerified;
    data['status'] = status;
    data['device_token'] = deviceToken;
    data['device_type'] = deviceType;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class ProjectCategory {
  String? name;
  String? color;

  ProjectCategory({
    this.name,
    this.color,
  });

  ProjectCategory.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    color = json['color']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}

class ProjectsDetail {
  int? id;
  String? projectCode;
  String? projectName;
  String? title;
  String? image;
  String? logo;
  String? address;
  String? description;
  String? projectStartDate;
  String? projectEndDate;
  String? projectStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<ProjectCategory?>? projectCategory;
  List<Users?>? users;
  List<ProjectImages?>? projectImages;

  ProjectsDetail({
    this.id,
    this.projectCode,
    this.projectName,
    this.title,
    this.image,
    this.logo,
    this.address,
    this.description,
    this.projectStartDate,
    this.projectEndDate,
    this.projectStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.projectCategory,
    this.users,
    this.projectImages,
  });

  ProjectsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    projectCode = json['project_code']?.toString();
    projectName = json['project_name']?.toString();
    title = json['title']?.toString();
    image = json['image']?.toString();
    logo = json['logo']?.toString();
    address = json['address']?.toString();
    description = json['description']?.toString();
    projectStartDate = json['project_start_date']?.toString();
    projectEndDate = json['project_end_date']?.toString();
    projectStatus = json['project_status']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    if (json['project_category'] != null) {
      final v = json['project_category'];
      final arr0 = <ProjectCategory>[];
      v.forEach((v) {
        arr0.add(ProjectCategory.fromJson(v));
      });
      projectCategory = arr0;
    }
    if (json['users'] != null) {
      final v = json['users'];
      final arr0 = <Users>[];
      v.forEach((v) {
        arr0.add(Users.fromJson(v));
      });
      users = arr0;
    }
    if (json['project_images'] != null) {
      final v = json['project_images'];
      final arr0 = <ProjectImages>[];
      v.forEach((v) {
        arr0.add(ProjectImages.fromJson(v));
      });
      projectImages = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['project_code'] = projectCode;
    data['project_name'] = projectName;
    data['title'] = title;
    data['image'] = image;
    data['logo'] = logo;
    data['address'] = address;
    data['description'] = description;
    data['project_start_date'] = projectStartDate;
    data['project_end_date'] = projectEndDate;
    data['project_status'] = projectStatus;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (projectCategory != null) {
      final v = projectCategory;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['project_category'] = arr0;
    }
    if (users != null) {
      final v = users;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['users'] = arr0;
    }
    if (projectImages != null) {
      final v = projectImages;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['project_images'] = arr0;
    }
    return data;
  }
}

class Data {
  List<ProjectsDetail?>? projectDetails;
  List<Reports?>? reports;
  List<String?>? images;
  List<Maintenance?>? maintenance;
  List<PunchLists?>? punchList;
  List<ScheduleList?>? scheduleList;
  List<TaskList?>? taskList;

  Data({
    this.projectDetails,
    this.reports,
    this.images,
    this.maintenance,
    this.punchList,
    this.scheduleList,
    this.taskList,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['project_details'] != null) {
      final v = json['project_details'];
      final arr0 = <ProjectsDetail>[];
      v.forEach((v) {
        arr0.add(ProjectsDetail.fromJson(v));
      });
      projectDetails = arr0;
    }
    if (json['reports'] != null) {
      final v = json['reports'];
      final arr0 = <Reports>[];
      v.forEach((v) {
        arr0.add(Reports.fromJson(v));
      });
      reports = arr0;
    }
    if (json['images'] != null) {
      final v = json['images'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images = arr0;
    }
    if (json['maintenance_list'] != null) {
      final v = json['maintenance_list'];
      final arr0 = <Maintenance>[];
      v.forEach((v) {
        arr0.add(Maintenance.fromJson(v));
      });
      maintenance = arr0;
    }
    if (json['punch_list'] != null) {
      final v = json['punch_list'];
      final arr0 = <PunchLists>[];
      v.forEach((v) {
        arr0.add(PunchLists.fromJson(v));
      });
      punchList = arr0;
    }
    if (json['schedule_list'] != null) {
      final v = json['schedule_list'];
      final arr0 = <ScheduleList>[];
      v.forEach((v) {
        arr0.add(ScheduleList.fromJson(v));
      });
      scheduleList = arr0;
    }
    if (json['task_list'] != null) {
      final v = json['task_list'];
      final arr0 = <TaskList>[];
      v.forEach((v) {
        arr0.add(TaskList.fromJson(v));
      });
      taskList = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (projectDetails != null) {
      final v = projectDetails;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['project_details'] = arr0;
    }
    if (reports != null) {
      final v = reports;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['reports'] = arr0;
    }
    if (images != null) {
      final v = images;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['images'] = arr0;
    }
    if (maintenance != null) {
      final v = maintenance;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['maintenance_list'] = arr0;
    }
    if (punchList != null) {
      final v = punchList;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['punch_list'] = arr0;
    }
    if (scheduleList != null) {
      final v = scheduleList;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['schedule_list'] = arr0;
    }
    if (taskList != null) {
      final v = taskList;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['task_list'] = arr0;
    }
    return data;
  }
}

class ProjectDetailsModal {
  bool? success;
  String? message;
  Data? data;

  ProjectDetailsModal({
    this.success,
    this.message,
    this.data,
  });

  ProjectDetailsModal.fromJson(Map<String, dynamic> json) {
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
