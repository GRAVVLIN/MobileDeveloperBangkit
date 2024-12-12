import 'dart:convert';
import '../responses/predict_spending_response_model.dart';

class PredictSpendingCacheModel {
  final String month;
  final DateTime lastUpdated;
  final PredictSpendingResponseModel data;

  PredictSpendingCacheModel({
    required this.month,
    required this.lastUpdated,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'month': month,
    'lastUpdated': lastUpdated.toIso8601String(),
    'data': jsonEncode(data),
  };

  factory PredictSpendingCacheModel.fromJson(Map<String, dynamic> json) =>
      PredictSpendingCacheModel(
        month: json['month'],
        lastUpdated: DateTime.parse(json['lastUpdated']),
        data: PredictSpendingResponseModel.fromJson(
          jsonDecode(json['data']),
        ),
      );
} 