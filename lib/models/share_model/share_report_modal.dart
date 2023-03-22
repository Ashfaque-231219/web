class ShareReportModal {
  bool? success;
  String? message;

  ShareReportModal({
    this.success,
    this.message,
  });

  ShareReportModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
