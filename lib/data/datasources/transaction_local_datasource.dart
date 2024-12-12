import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cache/transaction_cache_model.dart';
import '../models/responses/predict_spending_response_model.dart';
import '../models/responses/transaction_list_response_model.dart';
import '../models/cache/predict_spending_cache_model.dart';

class TransactionLocalDatasource {
  Future<void> saveTransactionCache(
    String month,
    TransactionListResponseModel data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cache = TransactionCacheModel(
      month: month,
      lastUpdated: DateTime.now(),
      data: data,
    );

    await prefs.setString('transaction_cache_$month', jsonEncode(cache.toJson()));
    print('💾 Cache saved for month: $month');
  }

  Future<TransactionCacheModel?> getTransactionCache(String month) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheStr = prefs.getString('transaction_cache_$month');
    if (cacheStr == null) return null;

    try {
      final cacheJson = jsonDecode(cacheStr);
      return TransactionCacheModel.fromJson(cacheJson);
    } catch (e) {
      print('❌ Error reading cache: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('transaction_cache_') || 
          key.startsWith('predict_spending_')) {
        await prefs.remove(key);
      }
    }
    print('🧹 Cache cleared');
  }

  bool isCacheValid(DateTime lastUpdated) {
    // Cache valid untuk 5 menit
    return DateTime.now().difference(lastUpdated).inMinutes < 5;
  }

  // Cache key untuk predict spending
  String _getPredictSpendingCacheKey(String month) => 'predict_spending_$month';

  Future<void> savePredictSpendingCache(
    String month,
    PredictSpendingResponseModel data,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cache = PredictSpendingCacheModel(
        month: month,
        lastUpdated: DateTime.now(),
        data: data,
      );

      final cacheString = jsonEncode(cache.toJson());
      await prefs.setString('predict_spending_$month', cacheString);
      print('💾 Predict spending cache saved for month: $month');
    } catch (e) {
      print('❌ Error saving predict spending cache: $e');
    }
  }

  Future<PredictSpendingResponseModel?> getPredictSpendingCache(String month) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheString = prefs.getString('predict_spending_$month');
      
      if (cacheString != null) {
        final cacheJson = jsonDecode(cacheString);
        final cache = PredictSpendingCacheModel.fromJson(cacheJson);
        
        if (isCacheValid(cache.lastUpdated)) {
          print('📦 Using predict spending cache for month: $month');
          return cache.data;
        }
        print('❌ Predict spending cache expired');
      }
      return null;
    } catch (e) {
      print('❌ Error getting predict spending cache: $e');
      return null;
    }
  }
} 