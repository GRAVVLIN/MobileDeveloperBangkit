import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../models/responses/financial_trend_response_model.dart';
import '../models/responses/income_distribution_response_model.dart';
import '../models/responses/expenses_distribution_response_model.dart';
import '../models/responses/monthly_summary_response_model.dart';
import 'auth_local_datasource.dart';
import '../../core/constants/variables.dart';

class AnalyticsRemoteDatasource {
  Future<Either<String, FinancialTrendResponseModel>> getFinancialTrend(
    String userId,
    String month,
  ) async {
    print('📡 API Call: Getting financial trend for $userId, month: $month');
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/analytics/financial-trend/$userId/$month'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        return Right(FinancialTrendResponseModel.fromJson(response.body));
      } else {
        return const Left('Gagal memuat data statistik');
      }
    } catch (e) {
      print('❌ Error in remote datasource: $e');
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, IncomeDistributionResponseModel>> getIncomeDistribution(
    String userId,
    String month,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/analytics/income-distribution/$userId/$month'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        return Right(IncomeDistributionResponseModel.fromJson(response.body));
      } else {
        return const Left('Gagal memuat data distribusi pendapatan');
      }
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, ExpensesDistributionResponseModel>> getExpensesDistribution(
    String userId,
    String month,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/analytics/expenses-distribution/$userId/$month'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        return Right(ExpensesDistributionResponseModel.fromJson(response.body));
      } else {
        return const Left('Gagal memuat data distribusi pengeluaran');
      }
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, MonthlySummaryResponseModel>> getMonthlySummary(
    String userId,
    String month,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/analytics/monthly-summary/$userId/$month'),
        headers: {
          'Authorization': 'Bearer ${authData?.token}',
        },
      );

      if (response.statusCode == 200) {
        return Right(MonthlySummaryResponseModel.fromJson(response.body));
      } else {
        return const Left('Gagal memuat ringkasan bulanan');
      }
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }
} 