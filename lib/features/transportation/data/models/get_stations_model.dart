// To parse this JSON data, do
//
//     final getCompanyStationModel = getCompanyStationModelFromJson(jsonString);

import 'dart:convert';

GetCompanyStationModel getCompanyStationModelFromJson(String str) => GetCompanyStationModel.fromJson(json.decode(str));

String getCompanyStationModelToJson(GetCompanyStationModel data) => json.encode(data.toJson());

class GetCompanyStationModel {
    String? msg;
    List<StationModel>? data;
    int? status;

    GetCompanyStationModel({
        this.msg,
        this.data,
        this.status,
    });

    factory GetCompanyStationModel.fromJson(Map<String, dynamic> json) => GetCompanyStationModel(
        msg: json["msg"],
        data: json["data"] == null ? [] : List<StationModel>.from(json["data"]!.map((x) => StationModel.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
    };
}

class StationModel {
    int? id;
    int? companyId;
    String? name;
    String? latitude;
    String? longitude;

    StationModel({
        this.id,
        this.companyId,
        this.name,
        this.latitude,
        this.longitude,
    });

    factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
    };
}
