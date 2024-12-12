import 'dart:convert';

class TransactionListResponseModel {
  final bool success;
  final String message;
  final TransactionListData data;

  TransactionListResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TransactionListResponseModel.fromJson(String str) =>
      TransactionListResponseModel.fromMap(json.decode(str));

  factory TransactionListResponseModel.fromMap(Map<String, dynamic> json) =>
      TransactionListResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: TransactionListData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'data': data.toMap(),
  };
}

class TransactionListData {
  final List<Transaction> transactions;
  final TransactionSummary summary;

  TransactionListData({
    required this.transactions,
    required this.summary,
  });

  factory TransactionListData.fromMap(Map<String, dynamic> json) =>
      TransactionListData(
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromMap(x))),
        summary: TransactionSummary.fromMap(json["summary"]),
      );

  Map<String, dynamic> toMap() => {
    'transactions': transactions.map((x) => x.toMap()).toList(),
    'summary': summary.toMap(),
  };
}

class TransactionSummary {
  final String month;
  final int totalIncome;
  final int totalExpenses;
  final int balance;
  final int saving;
  final int recommendedSavings;
  final DateTime lastUpdated;

  TransactionSummary({
    required this.month,
    required this.totalIncome,
    required this.totalExpenses,
    required this.balance,
    required this.saving,
    required this.recommendedSavings,
    required this.lastUpdated,
  });

  factory TransactionSummary.fromMap(Map<String, dynamic> json) =>
      TransactionSummary(
        month: json["month"] ?? "",
        totalIncome: json["totalIncome"] ?? 0,
        totalExpenses: json["totalExpenses"] ?? 0,
        balance: json["balance"] ?? 0,
        saving: json["saving"] ?? 0,
        recommendedSavings: json["recommendedSavings"] ?? 0,
        lastUpdated: DateTime.parse(json["lastUpdated"] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toMap() => {
    'month': month,
    'totalIncome': totalIncome,
    'totalExpenses': totalExpenses,
    'balance': balance,
    'saving': saving,
    'recommendedSavings': recommendedSavings,
    'lastUpdated': lastUpdated.toIso8601String(),
  };
}

class Transaction {
  final String id;
  final String type;
  final String category;
  final String? subCategory;
  final int amount;
  final String? note;
  final DateTime date;
  final DateTime createdAt;
  final int saving;

  Transaction({
    required this.id,
    required this.type,
    required this.category,
    this.subCategory,
    required this.amount,
    this.note,
    required this.date,
    required this.createdAt,
    required this.saving,
  });

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"] ?? '',
        type: json["type"]?.toString().toLowerCase() ?? '',
        category: json["category"] ?? '',
        subCategory: json["subCategory"],
        amount: json["amount"]?.toInt() ?? 0,
        note: json["note"],
        date: DateTime.parse(json["date"] ?? DateTime.now().toIso8601String()),
        createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
        saving: json["saving"]?.toInt() ?? 0,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'category': category,
    'subCategory': subCategory,
    'amount': amount,
    'note': note,
    'date': date.toIso8601String(),
  };
} 