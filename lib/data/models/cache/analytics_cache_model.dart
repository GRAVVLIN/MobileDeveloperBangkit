import 'dart:convert';
import '../responses/financial_trend_response_model.dart';
import '../responses/income_distribution_response_model.dart';
import '../responses/expenses_distribution_response_model.dart';
import '../responses/monthly_summary_response_model.dart';

class AnalyticsCacheModel {
  final String month;
  final DateTime lastUpdated;
  final FinancialTrendResponseModel? trendData;
  final IncomeDistributionResponseModel? incomeData;
  final ExpensesDistributionResponseModel? expensesData;
  final MonthlySummaryResponseModel? summaryData;

  AnalyticsCacheModel({
    required this.month,
    required this.lastUpdated,
    this.trendData,
    this.incomeData,
    this.expensesData,
    this.summaryData,
  });

  Map<String, dynamic> toJson() => {
        'month': month,
        'lastUpdated': lastUpdated.toIso8601String(),
        'trendData': trendData != null ? jsonEncode(trendData) : null,
        'incomeData': incomeData != null ? jsonEncode(incomeData) : null,
        'expensesData': expensesData != null ? jsonEncode(expensesData) : null,
        'summaryData': summaryData != null ? jsonEncode(summaryData) : null,
      };

  factory AnalyticsCacheModel.fromJson(Map<String, dynamic> json) =>
      AnalyticsCacheModel(
        month: json['month'],
        lastUpdated: DateTime.parse(json['lastUpdated']),
        trendData: json['trendData'] != null
            ? FinancialTrendResponseModel.fromJson(json['trendData'])
            : null,
        incomeData: json['incomeData'] != null
            ? IncomeDistributionResponseModel.fromJson(json['incomeData'])
            : null,
        expensesData: json['expensesData'] != null
            ? ExpensesDistributionResponseModel.fromJson(json['expensesData'])
            : null,
        summaryData: json['summaryData'] != null
            ? MonthlySummaryResponseModel.fromJson(json['summaryData'])
            : null,
      );
} 