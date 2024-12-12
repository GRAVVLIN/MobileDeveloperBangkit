import 'dart:convert';

class IncomeDistributionResponseModel {
  final List<String> categories;
  final List<int> amounts;
  final int totalIncome;

  IncomeDistributionResponseModel({
    required this.categories,
    required this.amounts,
    required this.totalIncome,
  });

  factory IncomeDistributionResponseModel.fromJson(String str) =>
      IncomeDistributionResponseModel.fromMap(json.decode(str));

  factory IncomeDistributionResponseModel.fromMap(Map<String, dynamic> json) =>
      IncomeDistributionResponseModel(
        categories: List<String>.from(json["categories"].map((x) => x)),
        amounts: List<int>.from(json["amounts"].map((x) => x)),
        totalIncome: json["totalIncome"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "amounts": amounts,
        "totalIncome": totalIncome,
      };
} 