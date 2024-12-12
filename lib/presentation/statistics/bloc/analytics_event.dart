part of 'analytics_bloc.dart';

@freezed
class AnalyticsEvent with _$AnalyticsEvent {
  const factory AnalyticsEvent.started() = _Started;
  const factory AnalyticsEvent.getFinancialTrend({
    required String userId,
    required String month,
  }) = _GetFinancialTrend;
  const factory AnalyticsEvent.getIncomeDistribution({
    required String userId,
    required String month,
  }) = _GetIncomeDistribution;
  const factory AnalyticsEvent.getExpensesDistribution({
    required String userId,
    required String month,
  }) = _GetExpensesDistribution;
  const factory AnalyticsEvent.getMonthlySummary({
    required String userId,
    required String month,
  }) = _GetMonthlySummary;
  const factory AnalyticsEvent.getPredictSpending({
    required String userId,
    required String month,
  }) = _GetPredictSpending;
} 