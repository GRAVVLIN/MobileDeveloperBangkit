part of 'transaction_list_bloc.dart';

@freezed
class TransactionListState with _$TransactionListState {
  const factory TransactionListState.initial() = _Initial;
  const factory TransactionListState.loading() = _Loading;
  const factory TransactionListState.error(String message) = _Error;
  const factory TransactionListState.loaded(TransactionListResponseModel data) = _Loaded;
} 