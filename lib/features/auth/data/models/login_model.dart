// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String? msg;
    UserDataModel? data;
    int? status;
    LoginModel({
        this.msg,
        this.data,
        this.status,
    });
    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        msg: json["msg"],
        data: json["data"] == null ? null : UserDataModel.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data?.toJson(),
        "status": status,
    };
}
class UserDataModel {
    int? id;
    String? name;
    dynamic phone;
    String? email;
    String? image;
    bool? isGoogle;
    String? googleImage;
    dynamic code;
    dynamic points;
    dynamic notifications;
    String? token;
    bool? isRegister;

    UserDataModel({
        this.id,
        this.name,
        this.phone,
        this.email,
        this.image,
        this.isGoogle,
        this.googleImage,
        this.code,
        this.points,
        this.notifications,
        this.token,
        this.isRegister,
    });

    factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        isGoogle: json["is_google"],
        googleImage: json["google_image"],
        code: json["code"],
        points: json["points"],
        notifications: json["notifications"],
        token: json["token"],
        isRegister: json["is_register"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "image": image,
        "is_google": isGoogle,
        "google_image": googleImage,
        "code": code,
        "points": points,
        "notifications": notifications,
        "token": token,
        "is_register": isRegister,
    };
}
