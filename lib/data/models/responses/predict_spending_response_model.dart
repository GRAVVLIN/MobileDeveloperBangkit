import 'dart:convert';

class PredictSpendingResponseModel {
  final Alert alert;
  final FinancialIndicators financialIndicators;
  final String prediction;
  final RiskAssessment riskAssessment;
  final SpendingStatus spendingStatus;

  PredictSpendingResponseModel({
    required this.alert,
    required this.financialIndicators,
    required this.prediction,
    required this.riskAssessment,
    required this.spendingStatus,
  });

  factory PredictSpendingResponseModel.fromJson(String str) =>
      PredictSpendingResponseModel.fromMap(json.decode(str));

  factory PredictSpendingResponseModel.fromMap(Map<String, dynamic> json) =>
      PredictSpendingResponseModel(
        alert: Alert.fromMap(json["alert"]),
        financialIndicators: FinancialIndicators.fromMap(json["financial_indicators"]),
        prediction: json["prediction"],
        riskAssessment: RiskAssessment.fromMap(json["risk_assessment"]),
        spendingStatus: SpendingStatus.fromMap(json["spending_status"]),
      );
}

class Alert {
  final String message;
  final List<String> recommendations;
  final String type;

  Alert({
    required this.message,
    required this.recommendations,
    required this.type,
  });

  factory Alert.fromMap(Map<String, dynamic> json) => Alert(
        message: json["message"],
        recommendations: List<String>.from(json["recommendations"].map((x) => x)),
        type: json["type"],
      );
}

class FinancialIndicators {
  final double predictionScore;
  final int savingsBalance;
  final int savingsPercentage;
  final int totalSpending;

  FinancialIndicators({
    required this.predictionScore,
    required this.savingsBalance,
    required this.savingsPercentage,
    required this.totalSpending,
  });

  factory FinancialIndicators.fromMap(Map<String, dynamic> json) =>
      FinancialIndicators(
        predictionScore: json["prediction_score"]?.toDouble() ?? 0.0,
        savingsBalance: json["savings_balance"]?.toInt() ?? 0,
        savingsPercentage: json["savings_percentage"]?.toInt() ?? 0,
        totalSpending: json["total_spending"]?.toInt() ?? 0,
      );
}

class RiskAssessment {
  final double financialHealthIndex;
  final String spendingRiskLevel;

  RiskAssessment({
    required this.financialHealthIndex,
    required this.spendingRiskLevel,
  });

  factory RiskAssessment.fromMap(Map<String, dynamic> json) => RiskAssessment(
        financialHealthIndex: json["financial_health_index"]?.toDouble() ?? 0.0,
        spendingRiskLevel: json["spending_risk_level"] ?? "",
      );
}

class SpendingStatus {
  final String code;
  final String description;
  final String level;

  SpendingStatus({
    required this.code,
    required this.description,
    required this.level,
  });

  factory SpendingStatus.fromMap(Map<String, dynamic> json) => SpendingStatus(
        code: json["code"] ?? "",
        description: json["description"] ?? "",
        level: json["level"] ?? "",
      );
}