class ReportTypeModel {
  bool? success;
  String? message;
  Data? data;

  ReportTypeModel({this.success, this.message, this.data});

  ReportTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ReportType>? reportType;

  Data({this.reportType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['report_type'] != null) {
      reportType = <ReportType>[];
      json['report_type'].forEach((v) {
        reportType!.add(ReportType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reportType != null) {
      data['report_type'] = reportType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportType {
  int? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  ReportType({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  ReportType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
