class ContactUSModelData {
  ContactUSModelData.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }
}

class ContactUSModel {
  bool? success;
  String? message;
  ContactUSModelData? data;

  ContactUSModel({
    this.success,
    this.message,
    this.data,
  });

  ContactUSModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? ContactUSModelData.fromJson(json['data']) : null;
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
