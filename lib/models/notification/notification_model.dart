class Notification {
  int? id;
  String? title;
  String? body;
  String? userId;
  String? referenceId;
  String? createdAt;
  String? updatedAt;
  String? date;

  Notification({
    this.id,
    this.title,
    this.body,
    this.userId,
    this.referenceId,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    body = json['body']?.toString();
    userId = json['user_id']?.toString();
    referenceId = json['reference_id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    date = json['date']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['user_id'] = userId;
    data['reference_id'] = referenceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['date'] = date;
    return data;
  }
}

class Data {
  List<List<Notification?>?>? notification;

  Data({
    this.notification,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notification'] != null) {
      final v = json['notification'];
      final arr0 = <List<Notification>>[];
      v.forEach((v) {
        final arr1 = <Notification>[];
        v.forEach((v) {
          arr1.add(Notification.fromJson(v));
        });
        arr0.add(arr1);
      });
      notification = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notification != null) {
      final v = notification;
      final arr0 = [];
      v!.forEach((v) {
        final arr1 = [];
        v!.forEach((v) {
          arr1.add(v!.toJson());
        });
        arr0.add(arr1);
      });
      data['notification'] = arr0;
    }
    return data;
  }
}

class NotificationModel {
  bool? success;
  Data? data;
  String? message;

  NotificationModel({
    this.success,
    this.data,
    this.message,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}
