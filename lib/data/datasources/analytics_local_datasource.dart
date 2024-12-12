import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cache/analytics_cache_model.dart';

class AnalyticsLocalDatasource {
  static const String _cacheKey = 'analytics_cache';

  Future<void> saveCache(AnalyticsCacheModel cache) async {
    try {
      print('💾 Saving to cache for month: ${cache.month}');
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = jsonEncode(cache.toJson());
      print('📦 Cache data: $jsonStr');
      await prefs.setString(_cacheKey, jsonStr);
      print('✅ Cache saved successfully');
    } catch (e) {
      print('❌ Error saving cache: $e');
      rethrow;
    }
  }

  Future<AnalyticsCacheModel?> getCache() async {
    try {
      print('🔍 Checking cache');
      final prefs = await SharedPreferences.getInstance();
      final cacheStr = prefs.getString(_cacheKey);
      if (cacheStr != null) {
        print('📦 Found cache: $cacheStr');
        return AnalyticsCacheModel.fromJson(jsonDecode(cacheStr));
      }
      print('❌ No cache found');
      return null;
    } catch (e) {
      print('❌ Error reading cache: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }

  // Check if cache is still valid (less than 5 minutes old)
  bool isCacheValid(AnalyticsCacheModel cache) {
    final now = DateTime.now();
    return now.difference(cache.lastUpdated).inMinutes < 5;
  }
} 