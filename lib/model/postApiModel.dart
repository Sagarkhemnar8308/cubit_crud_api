// To parse this JSON data, do
//
//     final postApiModel = postApiModelFromJson(jsonString);

import 'dart:convert';

PostApiModel postApiModelFromJson(String str) => PostApiModel.fromJson(json.decode(str));

String postApiModelToJson(PostApiModel data) => json.encode(data.toJson());

class PostApiModel {
    String? status;
    Data? data;

    PostApiModel({
        this.status,
        this.data,
    });

    factory PostApiModel.fromJson(Map<String, dynamic> json) => PostApiModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    String? email;
    String? password;
    String? id;
    int? v;

    Data({
        this.email,
        this.password,
        this.id,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        password: json["password"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "_id": id,
        "__v": v,
    };
}
