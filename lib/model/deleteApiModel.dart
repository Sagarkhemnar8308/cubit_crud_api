class DeleteModel {
    String? message;
    Data? data;

    DeleteModel({
        this.message,
        this.data,
    });

}

class Data {
    String? id;
    String? email;
    String? password;
    int? v;

    Data({
        this.id,
        this.email,
        this.password,
        this.v,
    });

}
