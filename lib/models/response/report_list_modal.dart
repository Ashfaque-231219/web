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

class Data {
  int? projectId;
  String? projectName;
  String? address;
  String? logo;
  String? image;
  int? id;
  int? userId;
  String? reportName;
  String? date;
  String? pdfUrl;
  String? reportId;
  String? createdAt;
  String? updatedAt;
  List<ProjectCategory?>? projectCategory;
  bool isChecked = false;

  Data({
    this.projectId,
    this.projectName,
    this.address,
    this.logo,
    this.image,
    this.id,
    this.userId,
    this.reportName,
    this.date,
    this.pdfUrl,
    this.reportId,
    this.createdAt,
    this.updatedAt,
    this.projectCategory,
    this.isChecked = false,
  });

  Data.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id']?.toInt();
    projectName = json['project_name']?.toString();
    address = json['address']?.toString();
    logo = json['logo']?.toString();
    image = json['image']?.toString();
    id = json['id']?.toInt();
    userId = json['user_id']?.toInt();
    reportName = json['report_name']?.toString();
    date = json['date']?.toString();
    pdfUrl = json['pdf_url']?.toString();
    reportId = json['report_id']?.toString();
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
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['address'] = address;
    data['logo'] = logo;
    data['image'] = image;
    data['id'] = id;
    data['user_id'] = userId;
    data['report_name'] = reportName;
    data['date'] = date;
    data['pdf_url'] = pdfUrl;
    data['report_id'] = reportId;
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
    return data;
  }
}

class ReportListModal {
  bool? success;
  String? message;
  List<Data?>? data;

  ReportListModal({
    this.success,
    this.message,
    this.data,
  });

  ReportListModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <Data>[];
      v.forEach((v) {
        arr0.add(Data.fromJson(v));
      });
      this.data = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['data'] = arr0;
    }
    return data;
  }
}
