import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../data/datasources/transaction_local_datasource.dart';
import '../../../../data/datasources/transaction_remote_datasource.dart';
import '../../../../data/models/requests/transaction_request_model.dart';
import '../../../../data/models/responses/transaction_response_model.dart';
import '../../../dashboard/bloc/transaction_list/transaction_list_bloc.dart';

part 'transaction_bloc.freezed.dart';
part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRemoteDatasource _transactionRemoteDatasource;
  final _localDatasource = TransactionLocalDatasource();

  TransactionBloc(this._transactionRemoteDatasource) : super(const _Initial()) {
    on<_CreateTransaction>((event, emit) async {
      await _localDatasource.clearCache();
      emit(const _Loading());
      final result = await _transactionRemoteDatasource.createTransaction(
        event.userId,
        event.request,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(_Loaded(data));
          event.context.read<TransactionListBloc>().add(
                TransactionListEvent.getTransactions(
                  userId: event.userId,
                  month: DateFormat('yyyy-MM').format(DateTime.now()),
                ),
              );
        },
      );
    });
  }
}
