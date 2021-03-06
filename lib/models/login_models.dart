// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.message,
    this.response,
    this.status,
  });

  String message;
  Response response;
  bool status;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    response: Response.fromJson(json["response"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "response": response.toJson(),
    "status": status,
  };
}

class Response {
  Response({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.img,
  });

  String id;
  String name;
  String email;
  String phone;
  String address;
  String img;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "img": img,
  };
}
