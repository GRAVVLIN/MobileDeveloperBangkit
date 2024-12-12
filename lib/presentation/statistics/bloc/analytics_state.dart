part of 'analytics_bloc.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.initial() = _Initial;
  const factory AnalyticsState.loading() = _Loading;
  const factory AnalyticsState.loadedTrend(FinancialTrendResponseModel data) = _LoadedTrend;
  const factory AnalyticsState.loadedDistribution(IncomeDistributionResponseModel data) = _LoadedDistribution;
  const factory AnalyticsState.loadedExpenses(ExpensesDistributionResponseModel data) = _LoadedExpenses;
  const factory AnalyticsState.loadedSummary(MonthlySummaryResponseModel data) = _LoadedSummary;
  const factory AnalyticsState.loadedPrediction(PredictSpendingResponseModel data) = _LoadedPrediction;
  const factory AnalyticsState.error(String message) = _Error;
} 