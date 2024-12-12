part of 'transaction_list_bloc.dart';

@freezed
class TransactionListEvent with _$TransactionListEvent {
  const factory TransactionListEvent.started() = _Started;
  const factory TransactionListEvent.getTransactions({
    required String userId,
    required String month,
  }) = _GetTransactions;
  const factory TransactionListEvent.refreshTransactions({
    required String userId,
    required String month,
  }) = _RefreshTransactions;
  const factory TransactionListEvent.updateSaving({
    required String userId,
    required int saving,
    required String month,
  }) = _UpdateSaving;
  const factory TransactionListEvent.deleteTransaction({
    required String transactionId,
    required String month,
  }) = _DeleteTransaction;
  const factory TransactionListEvent.getAllTransactionsByType({
    required String userId,
    required String month,
    required String type,
    String? lastTransactionId,
    int? limit,
    String? searchQuery,
  }) = _GetAllTransactionsByType;
  const factory TransactionListEvent.loadMoreTransactions({
    required String userId,
    required String month,
    required String type,
    required String lastTransactionId,
    int? limit,
    String? searchQuery,
  }) = _LoadMoreTransactions;
} 