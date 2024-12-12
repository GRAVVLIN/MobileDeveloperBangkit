import 'dart:convert';
import '../responses/transaction_list_response_model.dart';

class TransactionCacheModel {
  final String month;
  final DateTime lastUpdated;
  final TransactionListResponseModel data;

  TransactionCacheModel({
    required this.month,
    required this.lastUpdated,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'month': month,
        'lastUpdated': lastUpdated.toIso8601String(),
        'data': data.toMap(),
      };

  factory TransactionCacheModel.fromJson(Map<String, dynamic> json) =>
      TransactionCacheModel(
        month: json['month'],
        lastUpdated: DateTime.parse(json['lastUpdated']),
        data: TransactionListResponseModel.fromMap(
          json['data'] as Map<String, dynamic>,
        ),
      );
} 