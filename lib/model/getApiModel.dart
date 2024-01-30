class GetApiModel {
    String? status;
    List<Datum>? data;

    GetApiModel({
        this.status,
        this.data,
    });

    factory GetApiModel.fromJson(Map<String, dynamic> json) => GetApiModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? email;
    String? password;
    int? v;

    Datum({
        this.id,
        this.email,
        this.password,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "__v": v,
    };
}
