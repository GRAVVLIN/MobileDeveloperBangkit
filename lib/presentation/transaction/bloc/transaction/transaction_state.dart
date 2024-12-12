part of 'transaction_bloc.dart';

@freezed
class TransactionState with _$TransactionState {
  const factory TransactionState.initial() = _Initial;
  const factory TransactionState.loading() = _Loading;
  const factory TransactionState.loaded(TransactionResponseModel data) = _Loaded;
  const factory TransactionState.error(String message) = _Error;
} 