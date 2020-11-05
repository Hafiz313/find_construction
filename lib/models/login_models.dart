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
  List<Response> response;
  bool status;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
  });

  String id;
  String name;
  String phone;
  String address;
  String email;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "address": address,
    "email": email,
  };
}
