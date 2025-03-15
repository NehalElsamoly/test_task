// To parse this JSON data, do
//
//     final getCompaniesModel = getCompaniesModelFromJson(jsonString);

import 'dart:convert';

GetCompaniesModel getCompaniesModelFromJson(String str) => GetCompaniesModel.fromJson(json.decode(str));

String getCompaniesModelToJson(GetCompaniesModel data) => json.encode(data.toJson());

class GetCompaniesModel {
    String? msg;
    List<CompanyModel>? data;
    int? status;

    GetCompaniesModel({
        this.msg,
        this.data,
        this.status,
    });

    factory GetCompaniesModel.fromJson(Map<String, dynamic> json) => GetCompaniesModel(
        msg: json["msg"],
        data: json["data"] == null ? [] : List<CompanyModel>.from(json["data"]!.map((x) => CompanyModel.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
    };
}

class CompanyModel {
    int? id;
    String? name;
    int? moduleId;
    String? image;
    dynamic latitude;
    dynamic longitude;
    dynamic isFavorite;
    dynamic users;
    dynamic rate;
    

    CompanyModel({
        this.id,
        this.name,
        this.moduleId,
        this.image,
        this.latitude,
        this.longitude,
        this.isFavorite,
        this.users,
        this.rate
    });

    factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json["id"],
        name: json["name"],
        moduleId: json["module_id"],
        image: json["image"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isFavorite: json["is_fav"],
        users: json["users"],
        rate: json["rate"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "module_id": moduleId,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "is_fav": isFavorite,
        "users": users,
        "rate": rate
    };
}
