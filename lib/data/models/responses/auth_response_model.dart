import 'dart:convert';

class AuthResponseModel {
    final String? message;
    final String? token;
    final String? userId;

    AuthResponseModel({
        this.message,
        this.token,
        this.userId,
    });

    factory AuthResponseModel.fromJson(String str) => AuthResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponseModel.fromMap(Map<String, dynamic> json) => AuthResponseModel(
        message: json["message"],
        token: json["token"],
        userId: json["userId"],
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "token": token,
        "userId": userId,
    };
}
