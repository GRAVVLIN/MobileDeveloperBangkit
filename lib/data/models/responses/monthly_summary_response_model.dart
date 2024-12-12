import 'dart:convert';

class MonthlySummaryResponseModel {
  final int totalIncome;
  final int totalExpenses;
  final int netCashFlow;
  final int savings;
  final int recommendedSavings;
  final BreakdownData incomeBreakdown;
  final BreakdownData expensesBreakdown;

  MonthlySummaryResponseModel({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netCashFlow,
    required this.savings,
    required this.recommendedSavings,
    required this.incomeBreakdown,
    required this.expensesBreakdown,
  });

  factory MonthlySummaryResponseModel.fromJson(String str) =>
      MonthlySummaryResponseModel.fromMap(json.decode(str));

  factory MonthlySummaryResponseModel.fromMap(Map<String, dynamic> json) =>
      MonthlySummaryResponseModel(
        totalIncome: json["totalIncome"],
        totalExpenses: json["totalExpenses"],
        netCashFlow: json["netCashFlow"],
        savings: json["savings"],
        recommendedSavings: json["recommendedSavings"],
        incomeBreakdown: BreakdownData.fromMap(json["incomeBreakdown"]),
        expensesBreakdown: BreakdownData.fromMap(json["expensesBreakdown"]),
      );

  Map<String, dynamic> toJson() => {
        "totalIncome": totalIncome,
        "totalExpenses": totalExpenses,
        "netCashFlow": netCashFlow,
        "savings": savings,
        "recommendedSavings": recommendedSavings,
        "incomeBreakdown": incomeBreakdown.toJson(),
        "expensesBreakdown": expensesBreakdown.toJson(),
      };
}

class BreakdownData {
  final List<String> categories;
  final List<int> amounts;

  BreakdownData({
    required this.categories,
    required this.amounts,
  });

  factory BreakdownData.fromMap(Map<String, dynamic> json) => BreakdownData(
        categories: List<String>.from(json["categories"].map((x) => x)),
        amounts: List<int>.from(json["amounts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "amounts": amounts,
      };
} 