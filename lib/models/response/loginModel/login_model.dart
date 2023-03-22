class LoginModel {
  bool? success;
  String? message;
  String? token;
  String? androidAppUrl;
  String? androidAppVersion;
  String? iosAppUrl;
  String? iosAppVersion;
  Data? data;

  LoginModel({
    this.success,
    this.message,
    this.token,
    this.data,
    this.androidAppUrl,
    this.androidAppVersion,
    this.iosAppUrl,
    this.iosAppVersion,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    token = json['token']?.toString();
    androidAppUrl = json['android_app_url']?.toString();
    androidAppVersion = json['android_app_version']?.toString();
    iosAppUrl = json['ios_app_url']?.toString();
    iosAppVersion = json['ios_app_version']?.toString();
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    data['android_app_url'] = androidAppUrl;
    data['android_app_version'] = androidAppVersion;
    data['ios_app_url'] = iosAppUrl;
    data['ios_app_version'] = iosAppVersion;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? countryId;
  String? address;
  String? brand;
  String? officeNumber;
  String? position;
  String? team;
  String? region;
  String? userRoleId;
  String? employeeId;
  String? photo;
  String? otp;
  int? isVerified;
  String? status;
  String? updatedAt;
  String? createdAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.countryId,
    this.address,
    this.brand,
    this.officeNumber,
    this.position,
    this.team,
    this.region,
    this.userRoleId,
    this.employeeId,
    this.photo,
    this.otp,
    this.isVerified,
    this.status,
    this.updatedAt,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    countryId = json['country_id']?.toString();
    address = json['address']?.toString();
    brand = json['brand']?.toString();
    officeNumber = json['office_number']?.toString();
    position = json['position']?.toString();
    team = json['team']?.toString();
    region = json['region']?.toString();
    userRoleId = json['user_role_id']?.toString();
    employeeId = json['employee_id']?.toString();
    photo = json['photo']?.toString();
    otp = json['otp']?.toString();
    isVerified = json['is_verified']?.toInt();
    status = json['status']?.toString();
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_id'] = countryId;
    data['address'] = address;
    data['brand'] = brand;
    data['office_number'] = officeNumber;
    data['position'] = position;
    data['team'] = team;
    data['region'] = region;
    data['user_role_id'] = userRoleId;
    data['employee_id'] = employeeId;
    data['photo'] = photo;
    data['otp'] = otp;
    data['is_verified'] = isVerified;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
