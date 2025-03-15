// To parse this JSON data, do
//
//     final getAvailableBusesModel = getAvailableBusesModelFromJson(jsonString);

import 'dart:convert';

GetAvailableBusesModel getAvailableBusesModelFromJson(String str) => GetAvailableBusesModel.fromJson(json.decode(str));

String getAvailableBusesModelToJson(GetAvailableBusesModel data) => json.encode(data.toJson());

class GetAvailableBusesModel {
    String? msg;
    List<BusCompanyModel>? data;
    int? status;

    GetAvailableBusesModel({
        this.msg,
        this.data,
        this.status,
    });

    factory GetAvailableBusesModel.fromJson(Map<String, dynamic> json) => GetAvailableBusesModel(
        msg: json["msg"],
        data: json["data"] == null ? [] : List<BusCompanyModel>.from(json["data"]!.map((x) => BusCompanyModel.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
    };
}

class BusCompanyModel {
    int? id;
    String? code;
    String? plateNumber;
    BusModel? busModel;
    List<BusTimeInDeparture>? busTimeInDeparture;
    List<BusTimeInDeparture>?  busTimeInReturn;
     BusTimeInDeparture? selectedGoTime;
    BusTimeInDeparture? selectedReturnTime;

    BusCompanyModel({
        this.id,
        this.code,
        this.plateNumber,
        this.busModel,
        this.busTimeInDeparture,
        this.busTimeInReturn,
        this.selectedGoTime,
        this.selectedReturnTime
    });

    factory BusCompanyModel.fromJson(Map<String, dynamic> json) => BusCompanyModel(
        id: json["id"],
        code: json["code"],
        plateNumber: json["plate_number"],
        busModel: json["bus_model"] == null ? null : BusModel.fromJson(json["bus_model"]),
        busTimeInDeparture: json["busTimeInDeparture"] == null ? [] : List<BusTimeInDeparture>.from(json["busTimeInDeparture"]!.map((x) => BusTimeInDeparture.fromJson(x))),
        busTimeInReturn: json["busTimeInReturn"] == null ? [] : List<BusTimeInDeparture>.from(json["busTimeInReturn"].map((x) => BusTimeInDeparture.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "plate_number": plateNumber,
        "bus_model": busModel?.toJson(),
        "busTimeInDeparture": busTimeInDeparture == null ? [] : List<dynamic>.from(busTimeInDeparture!.map((x) => x.toJson())),
        "busTimeInReturn": busTimeInReturn == null ? [] : List<dynamic>.from(busTimeInReturn!.map((x) => x.toJson())),
    };
}

class BusModel {
    int? id;
    String? name;
    int? chairs;

    BusModel({
        this.id,
        this.name,
        this.chairs,
    });

    factory BusModel.fromJson(Map<String, dynamic> json) => BusModel(
        id: json["id"],
        name: json["name"],
        chairs: json["chairs"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chairs": chairs,
    };
}

class BusTimeInDeparture {
    int? id;
    String? fromTime;
    String? toTime;
    String? fromDay;
    String? toDay;
    dynamic price;
    String? fromStation;
    String? toStation;
   

    BusTimeInDeparture({
        this.id,
        this.fromTime,
        this.toTime,
        this.fromDay,
        this.toDay,
        this.price,
        this.fromStation,
        this.toStation,
    });
    factory BusTimeInDeparture.fromJson(Map<String, dynamic> json) => BusTimeInDeparture(
        id: json["id"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        fromDay: json["from_day"],
        toDay: json["to_day"],
        price: json["price"],
        fromStation: json["from_station"],
        toStation: json["to_station"],
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "from_time": fromTime,
        "to_time": toTime,
        "from_day": fromDay,
        "to_day": toDay,
        "price": price,
        "from_station": fromStation,
        "to_station": toStation,
    };
}
