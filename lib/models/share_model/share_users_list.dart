class Users {

  String? email;
  bool? checked = true;

  Users({
    this.email,
    this.checked = true
  });
  Users.fromJson(Map<String, dynamic> json) {
    email = json['email']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class Data {

  int? projectId;
  String? projectName;
  String? reportId;
  String? reportName;
  List<Users?>? users;

  Data({
    this.projectId,
    this.projectName,
    this.reportId,
    this.reportName,
    this.users,
  });
  Data.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id']?.toInt();
    projectName = json['project_name']?.toString();
    reportId = json['report_id']?.toString();
    reportName = json['report_name']?.toString();
    if (json['users'] != null) {
      final v = json['users'];
      final arr0 = <Users>[];
      v.forEach((v) {
        arr0.add(Users.fromJson(v));
      });
      users = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['report_id'] = reportId;
    data['report_name'] = reportName;
    if (users != null) {
      final v = users;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['users'] = arr0;
    }
    return data;
  }
}

class GetShareUsersList {

  bool? success;
  String? message;
  List<Data?>? data;

  GetShareUsersList({
    this.success,
    this.message,
    this.data,
  });
  GetShareUsersList.fromJson(Map<String, dynamic> json) {
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
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}
