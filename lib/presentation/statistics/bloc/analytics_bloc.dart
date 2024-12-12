import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/datasources/analytics_remote_datasource.dart';
import '../../../data/datasources/transaction_local_datasource.dart';
import '../../../data/models/cache/analytics_cache_model.dart';
import '../../../data/models/responses/financial_trend_response_model.dart';
import '../../../data/models/responses/income_distribution_response_model.dart';
import '../../../data/models/responses/expenses_distribution_response_model.dart';
import '../../../data/models/responses/monthly_summary_response_model.dart';
import '../../../data/datasources/analytics_local_datasource.dart';
import '../../../data/datasources/transaction_remote_datasource.dart';
import '../../../data/models/responses/predict_spending_response_model.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';
part 'analytics_bloc.freezed.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsRemoteDatasource _analyticsRemoteDatasource;
  final AnalyticsLocalDatasource _analyticsLocalDatasource;
  final TransactionRemoteDatasource _transactionRemoteDatasource;
  final TransactionLocalDatasource _transactionLocalDatasource;

  AnalyticsBloc(
    this._analyticsRemoteDatasource,
    this._analyticsLocalDatasource,
    this._transactionRemoteDatasource,
    this._transactionLocalDatasource,
  ) : super(const _Initial()) {
    on<_GetFinancialTrend>((event, emit) async {
      print('🔄 Getting Financial Trend for month: ${event.month}');
      emit(const _Loading());
      
      try {
        // Check cache first
        final cache = await _analyticsLocalDatasource.getCache();
        if (cache != null) {
          print('📦 Cache found: ${cache.month}');
          if (cache.month == event.month && 
              cache.trendData != null &&
              _analyticsLocalDatasource.isCacheValid(cache)) {
            print('✅ Using cached data');
            emit(_LoadedTrend(cache.trendData!));
            return;
          }
          print('❌ Cache invalid or expired');
        }

        final result = await _analyticsRemoteDatasource.getFinancialTrend(
          event.userId,
          event.month,
        );
        
        await result.fold(
          (error) async {
            print('❌ Error getting trend: $error');
            emit(_Error(error));
          },
          (data) async {
            print('✅ Got trend data: ${data.income.length} income entries, ${data.expenses.length} expense entries');
            try {
              await _analyticsLocalDatasource.saveCache(
                AnalyticsCacheModel(
                  month: event.month,
                  lastUpdated: DateTime.now(),
                  trendData: data,
                ),
              );
              print('💾 Saved to cache');
              if (!emit.isDone) {
                emit(_LoadedTrend(data));
              }
            } catch (e) {
              print('❌ Error saving to cache: $e');
              if (!emit.isDone) {
                emit(_LoadedTrend(data));
              }
            }
          },
        );
      } catch (e) {
        print('❌ Unexpected error: $e');
        if (!emit.isDone) {
          emit(_Error(e.toString()));
        }
      }
    });

    on<_GetIncomeDistribution>((event, emit) async {
      try {
        emit(const _Loading());
        final result = await _analyticsRemoteDatasource.getIncomeDistribution(
          event.userId,
          event.month,
        );
        await result.fold(
          (error) async => emit(_Error(error)),
          (data) async => emit(_LoadedDistribution(data)),
        );
      } catch (e) {
        if (!emit.isDone) {
          emit(_Error(e.toString()));
        }
      }
    });

    on<_GetExpensesDistribution>((event, emit) async {
      try {
        emit(const _Loading());
        print('🔄 Getting Expenses Distribution for month: ${event.month}');

        final result = await _analyticsRemoteDatasource.getExpensesDistribution(
          event.userId,
          event.month,
        );

        await result.fold(
          (error) async {
            print('❌ Error getting expenses: $error');
            if (!emit.isDone) {
              emit(_Error(error));
            }
          },
          (data) async {
            print('✅ Got expenses data: ${data.categories.length} categories');
            if (!emit.isDone) {
              emit(_LoadedExpenses(data));
            }
          },
        );
      } catch (e) {
        print('❌ Unexpected error in expenses: $e');
        if (!emit.isDone) {
          emit(_Error(e.toString()));
        }
      }
    });

    on<_GetMonthlySummary>((event, emit) async {
      try {
        emit(const _Loading());
        print('🔄 Getting Monthly Summary for month: ${event.month}');

        final result = await _analyticsRemoteDatasource.getMonthlySummary(
          event.userId,
          event.month,
        );

        await result.fold(
          (error) async {
            print('❌ Error getting summary: $error');
            if (!emit.isDone) {
              emit(_Error(error));
            }
          },
          (data) async {
            print('✅ Got summary data');
            if (!emit.isDone) {
              emit(_LoadedSummary(data));
            }
          },
        );
      } catch (e) {
        print('❌ Unexpected error in summary: $e');
        if (!emit.isDone) {
          emit(_Error(e.toString()));
        }
      }
    });

    on<_GetPredictSpending>((event, emit) async {
      emit(const _Loading());
      print('🔍 Getting predict spending for month: ${event.month}');
      
      // Check cache first
      final cache = await _transactionLocalDatasource.getPredictSpendingCache(event.month);
      if (cache != null) {
        print('📦 Using cached prediction data');
        emit(_LoadedPrediction(cache));
        return;
      }

      // If no cache, get from API
      final result = await _transactionRemoteDatasource.getPredictSpending(
        event.userId,
        event.month,
      );
      
      result.fold(
        (error) {
          print('❌ Error getting prediction: $error');
          emit(_Error(error));
        },
        (data) {
          print('✅ Got prediction data from API');
          // Save to cache
          _transactionLocalDatasource.savePredictSpendingCache(event.month, data);
          emit(_LoadedPrediction(data));
        },
      );
    });
  }

  // Helper method to clear cache on logout
  Future<void> clearCache() async {
    await _analyticsLocalDatasource.clearCache();
  }
} 