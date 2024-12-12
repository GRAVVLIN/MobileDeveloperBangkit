part of 'transaction_bloc.dart';

@freezed
class TransactionEvent with _$TransactionEvent {
  const factory TransactionEvent.started() = _Started;
  const factory TransactionEvent.createTransaction({
    required String userId,
    required TransactionRequestModel request,
    required BuildContext context,
  }) = _CreateTransaction;
} 
