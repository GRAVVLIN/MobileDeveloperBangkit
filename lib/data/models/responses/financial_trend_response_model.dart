import 'dart:convert';

class FinancialTrendResponseModel {
  final List<TransactionTrend> income;
  final List<TransactionTrend> expenses;
  final int savings;
  final int totalIncome;
  final int totalExpenses;
  final int netCashFlow;

  FinancialTrendResponseModel({
    required this.income,
    required this.expenses,
    required this.savings,
    required this.totalIncome,
    required this.totalExpenses,
    required this.netCashFlow,
  });

  factory FinancialTrendResponseModel.fromJson(String str) =>
      FinancialTrendResponseModel.fromMap(json.decode(str));

  factory FinancialTrendResponseModel.fromMap(Map<String, dynamic> json) =>
      FinancialTrendResponseModel(
        income: List<TransactionTrend>.from(
            json["income"].map((x) => TransactionTrend.fromMap(x))),
        expenses: List<TransactionTrend>.from(
            json["expenses"].map((x) => TransactionTrend.fromMap(x))),
        savings: json["savings"],
        totalIncome: json["totalIncome"],
        totalExpenses: json["totalExpenses"],
        netCashFlow: json["netCashFlow"],
      );

  Map<String, dynamic> toJson() => {
        "income": List<dynamic>.from(income.map((x) => x.toJson())),
        "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
        "savings": savings,
        "totalIncome": totalIncome,
        "totalExpenses": totalExpenses,
        "netCashFlow": netCashFlow,
      };
}

class TransactionTrend {
  final DateTime date;
  final int amount;
  final String category;
  final String? subCategory;

  TransactionTrend({
    required this.date,
    required this.amount,
    required this.category,
    this.subCategory,
  });

  factory TransactionTrend.fromMap(Map<String, dynamic> json) => TransactionTrend(
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
        category: json["category"],
        subCategory: json["subCategory"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "amount": amount,
        "category": category,
        "subCategory": subCategory,
      };
} 