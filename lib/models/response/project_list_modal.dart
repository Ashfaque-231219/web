class ProjectsListModel {
  bool? success;
  String? message;
  Data? data;

  ProjectsListModel({
    this.success,
    this.message,
    this.data,
  });

  ProjectsListModel.fromJson(Map<String, dynamic> json) {
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

class Data {
  String? currentDate;
  int? projectCount;
  List<ProjectDetailsList?>? projectDetails;

  Data({
    this.currentDate,
    this.projectCount,
    this.projectDetails,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentDate = json['current_date']?.toString();
    projectCount = json['project_count']?.toInt();
    if (json['project_details'] != null) {
      final v = json['project_details'];
      final arr0 = <ProjectDetailsList>[];
      v.forEach((v) {
        arr0.add(ProjectDetailsList.fromJson(v));
      });
      projectDetails = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['current_date'] = currentDate;
    data['project_count'] = projectCount;
    if (projectDetails != null) {
      final v = projectDetails;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['project_details'] = arr0;
    }
    return data;
  }
}

class ProjectDetailsList {
  int? id;
  String? projectName;
  String? address;
  String? logo;
  List<ProjectCategory?>? projectCategory;

  ProjectDetailsList({
    this.id,
    this.projectName,
    this.address,
    this.logo,
    this.projectCategory,
  });

  ProjectDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    projectName = json['project_name']?.toString();
    address = json['address']?.toString();
    logo = json['logo']?.toString();
    if (json['project_category'] != null) {
      final v = json['project_category'];
      final arr0 = <ProjectCategory>[];
      v.forEach((v) {
        arr0.add(ProjectCategory.fromJson(v));
      });
      projectCategory = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['address'] = address;
    data['logo'] = logo;
    if (projectCategory != null) {
      final v = projectCategory;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['project_category'] = arr0;
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
