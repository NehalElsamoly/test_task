// To parse this JSON data, do
//
//     final getListDataModel = getListDataModelFromJson(jsonString);

import 'dart:convert';

List<GetListDataModel> getListDataModelFromJson(String str) => List<GetListDataModel>.from(json.decode(str).map((x) => GetListDataModel.fromJson(x)));

String getListDataModelToJson(List<GetListDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetListDataModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  GetListDataModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory GetListDataModel.fromJson(Map<String, dynamic> json) => GetListDataModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
