class UserModel {
  String? userId;
  String? fullName;
  String? code;
  String? email;
  String? password;
  String? phone;
  String? image;
  bool? isActive;
  String? deviceId;

  UserModel({
    this.userId,
    this.email,
    this.phone,
    this.fullName,
    this.code,
    this.image,
    this.deviceId,
    this.password,
    this.isActive = true,
  });

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    fullName = map['fullName'];
    code = map['code'];
    email = map['email'];
    password = map['password'];
    phone = map['phone'];
    image = map['image'];
    isActive = map['isActive'];
    deviceId = map['deviceId'];
  }

  toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'code': code,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'isActive': isActive,
      'deviceId': deviceId,
    };
  }
}
