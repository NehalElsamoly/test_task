// To parse this JSON data, do
//
//     final getAvailableSeatsModel = getAvailableSeatsModelFromJson(jsonString);

import 'dart:convert';

GetAvailableSeatsModel getAvailableSeatsModelFromJson(String str) => GetAvailableSeatsModel.fromJson(json.decode(str));

String getAvailableSeatsModelToJson(GetAvailableSeatsModel data) => json.encode(data.toJson());

class GetAvailableSeatsModel {
    String? msg;
    Data? data;
    int? status;

    GetAvailableSeatsModel({
        this.msg,
        this.data,
        this.status,
    });

    factory GetAvailableSeatsModel.fromJson(Map<String, dynamic> json) => GetAvailableSeatsModel(
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data?.toJson(),
        "status": status,
    };
}

class Data {
    List<SeatModel>? departure;
    List<SeatModel>? dataReturn;

    Data({
        this.departure,
        this.dataReturn,
    });    factory Data.fromJson(Map<String, dynamic> json) => Data(
        departure: json["departure"] == null ? [] : List<SeatModel>.from(json["departure"]!.map((x) => SeatModel.fromJson(x))),
        dataReturn: json["return"] == null ? [] : List<SeatModel>.from(json["return"]!.map((x) => SeatModel.fromJson(x))),
    );
    Map<String, dynamic> toJson() => {
        "departure": departure == null ? [] : List<dynamic>.from(departure!.map((x) => x.toJson())),
        "return": dataReturn == null ? [] : List<dynamic>.from(dataReturn!.map((x) => x.toJson())),
    };
}

class SeatModel {
    int? id;
    int? number;
    int? status;

    SeatModel({
        this.id,
        this.number,
        this.status,
    });

    factory SeatModel.fromJson(Map<String, dynamic> json) => SeatModel(
        id: json["id"],
        number: json["number"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "status": status,
    };
}
