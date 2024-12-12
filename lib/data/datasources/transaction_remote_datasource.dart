import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/variables.dart';
import '../models/requests/transaction_request_model.dart';
import '../models/responses/transaction_response_model.dart';
import 'auth_local_datasource.dart';
import '../models/responses/transaction_list_response_model.dart';
import 'package:intl/intl.dart';
import './transaction_local_datasource.dart';
import '../models/responses/predict_spending_response_model.dart';

class TransactionRemoteDatasource {
  final _localDatasource = TransactionLocalDatasource();
  final baseUrl = Variables.baseUrl;

  Future<Either<String, TransactionResponseModel>> createTransaction(
    String userId,
    TransactionRequestModel request,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/transactions/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(TransactionResponseModel.fromJson(response.body));
      } else {
        final errorResponse = json.decode(response.body);
        return Left(errorResponse['message'] ?? 'Failed to create transaction');
      }
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, TransactionListResponseModel>> getTransactions(
    String userId,
    String month, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Check cache first
      final cache = await _localDatasource.getTransactionCache(month);
      if (cache != null && _localDatasource.isCacheValid(cache.lastUpdated)) {
        print('📦 Using cached data for month: $month');
        print('💾 Cache summary: saving=${cache.data.data.summary.saving}%');
        return Right(cache.data);
      }

      print('🌐 Fetching from API for month: $month');
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/transactions/$userId/$month?page=$page&limit=$limit'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      print('📡 API Response: ${response.statusCode}');
      print('📝 Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final result = TransactionListResponseModel.fromJson(response.body);
          // Save to cache
          await _localDatasource.saveTransactionCache(month, result);
          print('💾 Saved new data to cache for month: $month');
          return Right(result);
        } catch (e) {
          return const Left('Terjadi kesalahan saat memproses data');
        }
      } else if (response.statusCode == 401) {
        return const Left('Sesi Anda telah berakhir. Silakan login kembali.');
      } else {
        final errorResponse = json.decode(response.body);
        return Left(errorResponse['message'] ?? 'Gagal memuat data transaksi');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') || 
          e.toString().contains('Connection closed')) {
        return const Left('Koneksi internet bermasalah');
      }
      return const Left('Terjadi kesalahan. Silakan coba beberapa saat lagi');
    }
  }

  Future<Either<String, Map<String, dynamic>>> updateSaving(
    String userId,
    int saving,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      print('Updating saving: userId=$userId, saving=$saving');

      final response = await http.put(
        Uri.parse('${Variables.baseUrl}/transactions/$userId/update-saving'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
          'Content-Type': 'application/json',
        },
        body: json.encode({'saving': saving}),
      );

      print('Update saving response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        return Right(json.decode(response.body));
      } else if (response.statusCode == 401) {
        return const Left('Sesi Anda telah berakhir. Silakan login kembali.');
      } else {
        final errorResponse = json.decode(response.body);
        return Left(errorResponse['message'] ?? 'Gagal mengupdate progress tabungan');
      }
    } catch (e) {
      print('Error updating saving: $e');
      if (e.toString().contains('SocketException') || 
          e.toString().contains('Connection closed')) {
        return const Left('Koneksi internet bermasalah');
      }
      return const Left('Terjadi kesalahan saat mengupdate progress tabungan');
    }
  }

  Future<Either<String, dynamic>> deleteTransaction(
    String transactionId,
    String month,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      print('🗑️ Deleting transaction with ID: $transactionId');
      final response = await http.delete(
        Uri.parse('${Variables.baseUrl}/transactions/$transactionId/$month'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
          'Content-Type': 'application/json',
        },
      );

      print('📡 Delete response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        return const Left('Sesi Anda telah berakhir');
      } else {
        final errorResponse = json.decode(response.body);
        return Left(errorResponse['message'] ?? 'Gagal menghapus transaksi');
      }
    } catch (e) {
      print('❌ Delete error: $e');
      return const Left('Terjadi kesalahan saat menghapus transaksi');
    }
  }

  Future<Either<String, TransactionListResponseModel>> getTransactionsByType(
    String userId,
    String month, {
    required String type,
    String? lastTransactionId,
    int limit = 10,
    String? searchQuery,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      final queryParams = {
        'type': type,
        'limit': limit.toString(),
        'search': searchQuery ?? '',
        if (lastTransactionId != null) 'last_transaction_id': lastTransactionId,
      };

      print('🔍 Search query: "$searchQuery"');
      print('🔍 Query params: $queryParams');

      final url = Uri.parse('${Variables.baseUrl}/transactions/$userId/$month')
          .replace(queryParameters: queryParams);
      
      print('🌐 Request URL: $url');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      print('📡 Response status: ${response.statusCode}');
      print('📦 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = TransactionListResponseModel.fromJson(response.body);
        print('✅ Received ${result.data.transactions.length} transactions');
        return Right(result);
      } else if (response.statusCode == 401) {
        return const Left('Sesi Anda telah berakhir. Silakan login kembali.');
      } else {
        final errorResponse = json.decode(response.body);
        return Left(errorResponse['message'] ?? 'Gagal mengambil data transaksi');
      }
    } catch (e) {
      print('❌ Error: $e');
      return const Left('Terjadi kesalahan saat mengambil data');
    }
  }

  Future<Either<String, PredictSpendingResponseModel>> getPredictSpending(
    String userId,
    String month,
  ) async {
    try {
      // Check cache first
      final cache = await _localDatasource.getPredictSpendingCache(month);
      if (cache != null) {
        return Right(cache);
      }

      // If no cache, get from API
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.modelApiUrl}/predict-spending/$userId/$month'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = PredictSpendingResponseModel.fromJson(response.body);
        // Save to cache
        await _localDatasource.savePredictSpendingCache(month, data);
        return Right(data);
      } else {
        return const Left('Gagal mendapatkan prediksi pengeluaran');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String?> _getToken() async {
    final authData = await AuthLocalDatasource().getAuthData();
    return authData?.token;
  }
} 