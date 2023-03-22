class EditScheduleModel {
  bool? success;
  String? message;
  String? data;

  EditScheduleModel({
    this.success,
    this.message,
    this.data,
  });

  EditScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = json['data']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
