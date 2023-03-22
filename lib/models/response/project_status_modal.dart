class ProjectStatusModalData {
  String? status;

  ProjectStatusModalData({
    this.status,
  });

  ProjectStatusModalData.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class ProjectStatusModal {
  bool? success;
  String? message;
  ProjectStatusModalData? data;

  ProjectStatusModal({
    this.success,
    this.message,
    this.data,
  });

  ProjectStatusModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? ProjectStatusModalData.fromJson(json['data']) : null;
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
