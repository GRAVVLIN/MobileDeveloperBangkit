import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/datasources/auth_local_datasource.dart';
import '../../../../data/datasources/transaction_remote_datasource.dart';
import '../../../../data/models/responses/transaction_list_response_model.dart';
import 'package:intl/intl.dart';
import '../../../../data/datasources/transaction_local_datasource.dart';

part 'transaction_list_bloc.freezed.dart';
part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final TransactionRemoteDatasource _transactionRemoteDatasource;
  final _localDatasource = TransactionLocalDatasource();

  TransactionListBloc(this._transactionRemoteDatasource)
      : super(const _Initial()) {
    on<_GetTransactions>((event, emit) async {
      emit(const _Loading());
      final result = await _transactionRemoteDatasource.getTransactions(
        event.userId,
        event.month,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
          print('📊 Loaded transactions for ${event.month}:');
          print('💰 Summary: saving=${data.data.summary.saving}%');
          print('💳 Transactions: ${data.data.transactions.length} items');
          data.data.transactions.forEach((transaction) {
            print(
                '  - ${transaction.date.toString()}: ${transaction.category} (saving: ${transaction.saving}%)');
          });
          emit(_Loaded(data));
        },
      );
    });

    on<_RefreshTransactions>((event, emit) async {
      emit(const _Loading());
      await _localDatasource.clearCache();
      print('🧹 Cache cleared on refresh');

      final result = await _transactionRemoteDatasource.getTransactions(
        event.userId,
        event.month,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(_Loaded(data));
          print('💾 Data loaded from remote ${data.data.transactions}');
        },
      );
    });

    on<_GetAllTransactionsByType>((event, emit) async {
      try {
        emit(const _Loading());
        print('🔄 Getting transactions by type: ${event.type}');
        
        final result = await _transactionRemoteDatasource.getTransactionsByType(
          event.userId,
          event.month,
          type: event.type,
          lastTransactionId: event.lastTransactionId,
          limit: event.limit ?? 10,
          searchQuery: event.searchQuery,
        );

        result.fold(
          (error) => emit(_Error(error)),
          (data) {
            print('📊 Received transactions:');
            print('Total: ${data.data.transactions.length}');
            print('Type ${event.type}: ${data.data.transactions.where((t) => t.type == event.type).length}');
            emit(_Loaded(data));
          },
        );
      } catch (e) {
        print('❌ Error: $e');
        emit(_Error('Terjadi kesalahan yang tidak diketahui'));
      }
    });

    on<_LoadMoreTransactions>((event, emit) async {
      try {
        if (state is! _Loaded) return;
        
        print('🔄 Loading more transactions for type: ${event.type}');
        final result = await _transactionRemoteDatasource.getTransactionsByType(
          event.userId,
          event.month,
          type: event.type,
          lastTransactionId: event.lastTransactionId,
          limit: event.limit ?? 10,
          searchQuery: event.searchQuery,
        );

        result.fold(
          (error) => emit(_Error(error)),
          (newData) {
            final currentState = state as _Loaded;
            final updatedTransactions = [
              ...currentState.data.data.transactions,
              ...newData.data.transactions,
            ];
            
            print('📊 Added ${newData.data.transactions.length} new transactions');
            
            emit(_Loaded(TransactionListResponseModel(
              success: true,
              data: TransactionListData(
                transactions: updatedTransactions,
                summary: currentState.data.data.summary,
              ),
              message: newData.message,
            )));
          },
        );
      } catch (e) {
        print('❌ Error: $e');
        emit(const _Error('Terjadi kesalahan saat memuat data tambahan'));
      }
    });

    on<_UpdateSaving>((event, emit) async {
      try {
        await _localDatasource.clearCache();
        emit(const _Loading());
        final result = await _transactionRemoteDatasource.updateSaving(
          event.userId,
          event.saving,
        );

        await result.fold(
          (error) async {
            emit(_Error(error));
          },
          (data) async {
            // Refresh data transaksi setelah update berhasil
            final transactionResult =
                await _transactionRemoteDatasource.getTransactions(
              event.userId,
              event.month,
            );

            emit(
              await transactionResult.fold(
                (error) => _Error(error),
                (data) => _Loaded(data),
              ),
            );
          },
        );
      } catch (e) {
        emit(_Error('Terjadi kesalahan yang tidak diketahui'));
      }
    });

    on<_DeleteTransaction>((event, emit) async {
      try {
      await _localDatasource.clearCache();

        emit(const _Loading());
        final result = await _transactionRemoteDatasource.deleteTransaction(
          event.transactionId,
          event.month,
        );

        await result.fold(
          (error) async {
            emit(_Error(error));
          },
          (_) async {
            final authData = await AuthLocalDatasource().getAuthData();
            if (authData?.userId != null) {
              final transactionResult = await _transactionRemoteDatasource.getTransactions(
                authData!.userId!,
                event.month,

              );

              emit(
                transactionResult.fold(
                  (error) => _Error(error),
                  (data) => _Loaded(data),
                ),
              );
            }
          },
        );
      } catch (e) {
        emit(_Error('Terjadi kesalahan yang tidak diketahui'));
      }
    });
  }
}
