import 'dart:convert';

class ExpensesDistributionResponseModel {
  final List<String> categories;
  final List<int> amounts;
  final int totalExpenses;

  ExpensesDistributionResponseModel({
    required this.categories,
    required this.amounts,
    required this.totalExpenses,
  });

  factory ExpensesDistributionResponseModel.fromJson(String str) =>
      ExpensesDistributionResponseModel.fromMap(json.decode(str));

  factory ExpensesDistributionResponseModel.fromMap(Map<String, dynamic> json) =>
      ExpensesDistributionResponseModel(
        categories: List<String>.from(json["categories"].map((x) => x)),
        amounts: List<int>.from(json["amounts"].map((x) => x)),
        totalExpenses: json["totalExpenses"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "amounts": amounts,
        "totalExpenses": totalExpenses,
      };
} 