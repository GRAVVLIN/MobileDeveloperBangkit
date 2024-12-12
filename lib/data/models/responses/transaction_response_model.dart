import 'dart:convert';

class TransactionResponseModel {
    final String status;
    final String message;
    final TransactionData data;

    TransactionResponseModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TransactionResponseModel.fromJson(String str) => 
        TransactionResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TransactionResponseModel.fromMap(Map<String, dynamic> json) => 
        TransactionResponseModel(
            status: json["status"],
            message: json["message"],
            data: TransactionData.fromMap(json["data"]),
        );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
    };
}

class TransactionData {
    final String transactionId;
    final String type;
    final String category;
    final String? subCategory;
    final int amount;
    final String? note;
    final DateTime date;
    final DateTime createdAt;
    final int saving;
    final int currentBalance;
    final int recommendedSavings;

    TransactionData({
        required this.transactionId,
        required this.type,
        required this.category,
        this.subCategory,
        required this.amount,
        this.note,
        required this.date,
        required this.createdAt,
        required this.saving,
        required this.currentBalance,
        required this.recommendedSavings,
    });

    factory TransactionData.fromMap(Map<String, dynamic> json) => TransactionData(
        transactionId: json["transactionId"],
        type: json["type"],
        category: json["category"],
        subCategory: json["subCategory"],
        amount: json["amount"],
        note: json["note"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        saving: json["saving"],
        currentBalance: json["currentBalance"],
        recommendedSavings: json["recommendedSavings"],
    );

    Map<String, dynamic> toMap() => {
        "transactionId": transactionId,
        "type": type,
        "category": category,
        "subCategory": subCategory,
        "amount": amount,
        "note": note,
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "saving": saving,
        "currentBalance": currentBalance,
        "recommendedSavings": recommendedSavings,
    };
} 