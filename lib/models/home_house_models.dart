// To parse this JSON data, do
//
//     final houseHomeModel = houseHomeModelFromJson(jsonString);

import 'dart:convert';



HouseHomeModel houseHomeModelFromJson(String str) => HouseHomeModel.fromJson(json.decode(str));

String houseHomeModelToJson(HouseHomeModel data) => json.encode(data.toJson());

class HouseHomeModel {
  HouseHomeModel({
    this.message,
    this.response,
    this.status,
  });

  String message;
  List<Response> response;
  bool status;

  factory HouseHomeModel.fromJson(Map<String, dynamic> json) => HouseHomeModel(
    message: json["message"],
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
    "status": status,
  };
}

class Response {
  Response({
    this.name,
    this.icon,
    this.bedroom,
    this.washroom,
    this.kitchen,
    this.location,
    this.shortDetail,
    this.description,
    this.video,
  });

  String name;
  String icon;
  String bedroom;
  String washroom;
  String kitchen;
  String location;
  String shortDetail;
  String description;
  String video;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    name: json["name"],
    icon: json["icon"],
    bedroom: json["bedroom"],
    washroom: json["washroom"],
    kitchen: json["kitchen"],
    location: json["location"],
    shortDetail: json["short_detail"],
    description: json["description"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
    "bedroom": bedroom,
    "washroom": washroom,
    "kitchen": kitchen,
    "location": location,
    "short_detail": shortDetail,
    "description": description,
    "video": video,
  };
}
