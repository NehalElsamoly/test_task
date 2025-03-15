// To parse this JSON data, do
//
//     final addBusReservationModel = addBusReservationModelFromJson(jsonString);

import 'dart:convert';

AddBusReservationModel addBusReservationModelFromJson(String str) =>
    AddBusReservationModel.fromJson(json.decode(str));

String addBusReservationModelToJson(AddBusReservationModel data) =>
    json.encode(data.toJson());

class AddBusReservationModel {
  String? msg;
  Data? data;
  int? status;

  AddBusReservationModel({
    this.msg,
    this.data,
    this.status,
  });

  factory AddBusReservationModel.fromJson(Map<String, dynamic> json) =>
      AddBusReservationModel(
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
  int? id;
  dynamic totalPrice;
  dynamic vat;
  dynamic totalPriceAfterVat;
  dynamic rule;
  List<ReservedChairsNumber>? departureReservedChairsNumber;
  List<ReservedChairsNumber>? returnReservedChairsNumber;
  Data({
    this.totalPrice,
    this.id,
    this.vat,
    this.totalPriceAfterVat,
    this.rule,
    this.departureReservedChairsNumber,
    this.returnReservedChairsNumber,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        totalPrice: json["total_price"],
        vat: json["vat"],
        totalPriceAfterVat: json["total_price_after_vat"],
        rule: json["rule"],
        departureReservedChairsNumber:
            json["departureReservedChairsNumber"] == null
                ? []
                : List<ReservedChairsNumber>.from(
                    json["departureReservedChairsNumber"]!
                        .map((x) => ReservedChairsNumber.fromJson(x))),
        returnReservedChairsNumber: json["returnReservedChairsNumber"] == null
            ? []
            : List<ReservedChairsNumber>.from(
                json["returnReservedChairsNumber"]!
                    .map((x) => ReservedChairsNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total_price": totalPrice,
        "vat": vat,
        "total_price_after_vat": totalPriceAfterVat,
        "rule": rule,
        "departureReservedChairsNumber": departureReservedChairsNumber == null
            ? []
            : List<dynamic>.from(
                departureReservedChairsNumber!.map((x) => x.toJson())),
        "returnReservedChairsNumber": returnReservedChairsNumber == null
            ? []
            : List<dynamic>.from(
                returnReservedChairsNumber!.map((x) => x.toJson())),
      };
}

class ReservedChairsNumber {
  int? id;
  int? number;
  int? status;

  ReservedChairsNumber({
    this.id,
    this.number,
    this.status,
  });

  factory ReservedChairsNumber.fromJson(Map<String, dynamic> json) =>
      ReservedChairsNumber(
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
