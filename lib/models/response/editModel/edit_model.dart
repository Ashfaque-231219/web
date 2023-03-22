class EditModel {
  bool? success;
  String? message;
  Data? data;

  EditModel({this.success, this.message, this.data});

  EditModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? email;
  String? employeeId;
  dynamic userRoleId;
  String? phone;
  String? address;
  String? photo;
  String? otp;
  int? isVerified;
  String? status;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.employeeId,
        this.userRoleId,
        this.phone,
        this.address,
        this.photo,
        this.otp,
        this.isVerified,
        this.status,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    employeeId = json['employee_id'];
    userRoleId = json['user_role_id'];
    phone = json['phone'];
    address = json['address'];
    photo = json['photo'];
    otp = json['otp'];
    isVerified = json['is_verified'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['employee_id'] = employeeId;
    data['user_role_id'] = userRoleId;
    data['phone'] = phone;
    data['address'] = address;
    data['photo'] = photo;
    data['otp'] = otp;
    data['is_verified'] = isVerified;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}